#!/usr/bin/env bash
# ============================================================
# fedora_install.sh — Fedora KDE post-install setup script
#
# What this script does:
#   CLEANUP
#   1. Removes KDE games packages (kmahjongg, kmines, kpat, libkmahjongg)
#   2. Removes multimedia thumbnailers (kdegraphics-thumbnailers, kdegraphics-mobipocket)
#   3. Removes KDE PIM / Office packages (kdepim, kaddressbook, kcalc, etc.)
#   4. Removes KDE settings packages (kde-connect, kde-partitionmanager, etc.)
#   5. Removes Flatpak applications and the Flatpak runtime
#
#   INSTALL
#   6.  Visual Studio Code (native RPM from Microsoft repo)
#   7.  JetBrains Mono Font (native Fedora package)
#   8.  ONLYOFFICE Desktop Editors (native RPM)
#   9.  Zsh + plugins (zsh-autosuggestions, zsh-z, zsh-syntax-highlighting)
#   10. Starship prompt
#   11. Deploys .zshrc from dotfiles repo
#   12. Sets Zsh as the default shell
#
# Usage:
#   sudo bash fedora_install.sh
#
# WARNING: This script will remove packages. Review before running.
#          Ensure you have backups.
# ============================================================

set -euo pipefail

# ------------------------------------------------------------
# Global Configuration & Constants
# ------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SOURCE_ZSHRC="${REPO_ROOT}/config/.zshrc"
ZSH_PLUGIN_DIR="${HOME}/.zsh"
readonly BACKUP_FILE="/tmp/fedora_install_backup_$(date +%Y%m%d_%H%M%S).txt"

# Colors for formatted logging
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# ------------------------------------------------------------
# Logging & Helper Functions
# ------------------------------------------------------------
log_info()  { echo -e "${GREEN}[INFO]${NC}  $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC}  $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

confirm() {
    local prompt="$1"
    local choice
    read -r -p "${prompt} (y/N): " choice
    case "${choice}" in
        y|Y ) return 0 ;;
        * )   return 1 ;;
    esac
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root. Please run: sudo bash $0"
        exit 1
    fi
}

# Install or update a git-based plugin (idempotent)
clone_or_update() {
    local repo_url="$1"
    local dest_dir="$2"
    local plugin_name="$3"

    if [[ -d "${dest_dir}/.git" ]]; then
        log_info "Updating ${plugin_name}..."
        git -C "${dest_dir}" pull --ff-only || log_warn "Failed to update ${plugin_name}. Continuing..."
    else
        log_info "Cloning ${plugin_name}..."
        mkdir -p "$(dirname "${dest_dir}")"
        git clone --depth=1 "${repo_url}" "${dest_dir}"
    fi
}

# ============================================================
# SECTION 1: Summary & Confirmation
# ============================================================
show_summary() {
    echo ""
    echo "=========================================================="
    echo "  Fedora Post-Install Setup Script"
    echo "  Generated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "  Host: $(hostname)"
    echo "  User: $(id -un)"
    echo "=========================================================="
    echo ""
    echo "This script will REMOVE:"
    echo "  1. KDE games (kmahjongg, kmines, kpat, libkmahjongg)"
    echo "  2. Multimedia thumbnailers (kdegraphics-thumbnailers, kdegraphics-mobipocket)"
    echo "  3. KDE PIM / Office (kdepim-addons, kaddressbook, kcalc, etc.)"
    echo "  4. KDE settings packages (kde-connect, kde-partitionmanager, etc.)"
    echo "  5. Flatpak applications and the Flatpak runtime"
    echo ""
    echo "This script will INSTALL:"
    echo "  - DNF tuned (max_parallel_downloads=10, fastestmirror=True)"
    echo "  - Visual Studio Code (native RPM, Microsoft repo)"
    echo "  - JetBrains Mono Nerd Font (github.com/ryanoasis/nerd-fonts)"
    echo "  - ONLYOFFICE Desktop Editors (native RPM, ~280MB)"
    echo "  - Zsh + plugins (autosuggestions, zsh-z, syntax-highlighting)"
    echo "  - Starship prompt"
    echo ""

    if ! confirm "Do you want to proceed?"; then
        log_info "Operation cancelled by user."
        exit 0
    fi
}

# ============================================================
# SECTION 2: Backup Current Package State
# ============================================================
create_backup() {
    log_info "Creating backup of currently installed packages..."
    if dnf list installed > "${BACKUP_FILE}" 2>/dev/null; then
        log_info "Backup saved to: ${BACKUP_FILE}"
    else
        log_warn "Failed to create package backup. Continuing anyway..."
    fi
}

# ============================================================
# SECTION 3: Configure DNF for Faster Downloads
# ============================================================
# Writes settings idempotently: updates existing keys, appends missing ones.
configure_dnf() {
    log_info "==> Tuning DNF configuration for faster downloads..."
    local dnf_conf="/etc/dnf/dnf.conf"

    if [[ ! -f "${dnf_conf}" ]]; then
        log_warn "${dnf_conf} not found. Skipping DNF tuning."
        return 0
    fi

    # key=value pairs to apply
    local -A settings=(
        [max_parallel_downloads]="10"
        [fastestmirror]="True"
        [defaultyes]="True"
    )

    for key in "${!settings[@]}"; do
        local value="${settings[$key]}"
        if grep -q "^${key}=" "${dnf_conf}"; then
            # Update existing entry in place
            sed -i "s|^${key}=.*|${key}=${value}|" "${dnf_conf}"
        else
            # Append under [main] section if present, otherwise just append
            if grep -q "^\[main\]" "${dnf_conf}"; then
                sed -i "/^\[main\]/a ${key}=${value}" "${dnf_conf}"
            else
                echo "${key}=${value}" >> "${dnf_conf}"
            fi
        fi
        log_info "  DNF: ${key}=${value}"
    done

    log_info "DNF configuration updated. Parallel downloads: 10, fastestmirror: enabled."
}

# ============================================================
# SECTION 4: Update Package Metadata
# ============================================================
update_metadata() {
    log_info "Updating package metadata..."
    dnf makecache -q

    log_info "Ensuring dnf-utils is installed..."
    dnf install -y dnf-utils || log_warn "Failed to install dnf-utils. Continuing with default dnf..."
}

# ============================================================
# SECTION 4: Remove KDE Games
# ============================================================
remove_kde_games() {
    log_info "==> Removing KDE games packages..."
    local pkgs=(kmahjongg kmines kpat libkmahjongg)
    dnf remove -y "${pkgs[@]}" || log_warn "Some KDE games packages were not found or could not be removed."
}

# ============================================================
# SECTION 5: Remove Multimedia Thumbnailers
# ============================================================
remove_multimedia() {
    log_info "==> Removing unnecessary multimedia thumbnailers..."
    local pkgs=(kdegraphics-thumbnailers kdegraphics-mobipocket)
    dnf remove -y "${pkgs[@]}" || log_warn "Some multimedia packages were not found or could not be removed."
}

# ============================================================
# SECTION 6: Remove KDE PIM / Office Packages
# ============================================================
remove_kde_pim() {
    log_info "==> Removing KDE PIM / Office packages..."
    local pkgs=(
        kdepim-addons kdepim-runtime kdepim-runtime-libs
        kaddressbook keditbookmarks kcalc kcalutils kcharselect
    )
    dnf remove -y "${pkgs[@]}" || log_warn "Some KDE PIM packages were not found or could not be removed."
}

# ============================================================
# SECTION 7: Remove KDE Settings Packages
# ============================================================
remove_kde_settings() {
    log_info "==> Removing KDE settings packages..."
    local pkgs=(
        kde-filesystem-5 kde-l10n
        kde-settings-44 kde-settings-plasma kde-settings-plasmalogin kde-settings-pulseaudio
        kde-cli-tools kde-inotify-survey kde-gtk-config
        kde-connect kde-connect-libs kde-partitionmanager
    )
    dnf remove -y "${pkgs[@]}" || log_warn "Some KDE settings packages were not found or could not be removed."
}

# ============================================================
# SECTION 8: Remove Flatpak
# ============================================================
remove_flatpak() {
    log_info "==> Removing Flatpak packages and runtime..."
    if command -v flatpak &>/dev/null; then
        log_info "Uninstalling installed Flatpak applications..."
        flatpak uninstall --all --delete-data -y 2>/dev/null || true
    fi

    if rpm -q flatpak &>/dev/null; then
        dnf remove -y flatpak || log_warn "Could not remove flatpak package."
    fi
}

# ============================================================
# SECTION 9: Install Visual Studio Code
# ============================================================
install_vscode() {
    log_info "==> Installing Visual Studio Code (native RPM)..."

    rpm --import https://packages.microsoft.com/keys/microsoft.asc

    cat > /etc/yum.repos.d/vscode.repo << 'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

    dnf install -y code
    log_info "Visual Studio Code installed successfully."
}

# ============================================================
# SECTION 10: Install JetBrains Mono Nerd Font
# ============================================================
install_fonts() {
    log_info "==> Installing JetBrains Mono Nerd Font..."

    local font_dir="/usr/local/share/fonts/JetBrainsMonoNF"
    local nf_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
    local tmp_dir
    tmp_dir="$(mktemp -d)"
    local archive="${tmp_dir}/JetBrainsMono.tar.xz"

    log_info "Downloading from GitHub: ryanoasis/nerd-fonts..."
    if curl -fsSL --retry 3 --retry-delay 2 "${nf_url}" -o "${archive}"; then
        mkdir -p "${font_dir}"
        tar -xf "${archive}" -C "${font_dir}"
        rm -f "${tmp_dir}"
        # Refresh font cache system-wide
        if command -v fc-cache &>/dev/null; then
            fc-cache -f "${font_dir}"
            log_info "Font cache refreshed."
        fi
        log_info "JetBrains Mono Nerd Font installed to ${font_dir}"
    else
        log_warn "GitHub download failed. Falling back to Fedora repository package..."
        rm -rf "${tmp_dir}"
        if ! dnf install -y jetbrains-mono-fonts-all; then
            dnf install -y jetbrains-mono-fonts || log_warn "Failed to install JetBrains Mono font. Continuing..."
        fi
    fi
}

# ============================================================
# SECTION 11: Install ONLYOFFICE Desktop Editors
# ============================================================
install_onlyoffice() {
    log_info "==> Installing ONLYOFFICE Desktop Editors (native RPM)..."

    local rpm_path="/tmp/onlyoffice-desktopeditors.x86_64.rpm"
    local rpm_url="https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm"

    log_info "Downloading ONLYOFFICE RPM (~280MB)..."
    if ! curl -fsSL --retry 3 --retry-delay 2 "${rpm_url}" -o "${rpm_path}"; then
        log_warn "Failed to download ONLYOFFICE RPM. Skipping ONLYOFFICE installation."
        return 0
    fi

    log_info "Installing ONLYOFFICE Desktop Editors..."
    if dnf install -y "${rpm_path}"; then
        rm -f "${rpm_path}"
        log_info "ONLYOFFICE Desktop Editors installed successfully."
        log_info "Launch with: desktopeditors"
    else
        log_warn "Failed to install ONLYOFFICE Desktop Editors. Continuing..."
        rm -f "${rpm_path}"
    fi
}

# ============================================================
# SECTION 12: Install Zsh & Plugins
# ============================================================
install_zsh() {
    log_info "==> Installing Zsh and prerequisites..."
    dnf install -y curl zsh git

    mkdir -p "${ZSH_PLUGIN_DIR}"
    clone_or_update "https://github.com/zsh-users/zsh-autosuggestions"       "${ZSH_PLUGIN_DIR}/zsh-autosuggestions"       "zsh-autosuggestions"
    clone_or_update "https://github.com/agkozak/zsh-z"                       "${ZSH_PLUGIN_DIR}/zsh-z"                     "zsh-z"
    clone_or_update "https://github.com/zsh-users/zsh-syntax-highlighting"   "${ZSH_PLUGIN_DIR}/zsh-syntax-highlighting"   "zsh-syntax-highlighting"
}

# ============================================================
# SECTION 13: Install Starship Prompt
# ============================================================
install_starship() {
    if command -v starship &>/dev/null; then
        log_info "Starship is already installed. Skipping."
    else
        log_info "==> Installing Starship prompt..."
        # Run as the sudo-calling user if SUDO_USER is set, otherwise run as current user
        if [[ -n "${SUDO_USER:-}" ]]; then
            sudo -u "${SUDO_USER}" bash -c 'curl -sS https://starship.rs/install.sh | sh -s -- -y'
        else
            curl -sS https://starship.rs/install.sh | sh -s -- -y
        fi
    fi
}

# ============================================================
# SECTION 14: Deploy .zshrc from Dotfiles
# ============================================================
deploy_zshrc() {
    # Resolve source .zshrc — prefer config/.zshrc, fall back to repo root
    if [[ ! -f "${SOURCE_ZSHRC}" ]] && [[ -f "${REPO_ROOT}/.zshrc" ]]; then
        SOURCE_ZSHRC="${REPO_ROOT}/.zshrc"
    fi

    local target_user="${SUDO_USER:-${USER}}"
    local target_home
    target_home="$(eval echo "~${target_user}")"

    if [[ -f "${SOURCE_ZSHRC}" ]]; then
        if [[ -f "${target_home}/.zshrc" ]]; then
            local bak="${target_home}/.zshrc.bak.$(date +%Y%m%d_%H%M%S)"
            log_info "Existing ~/.zshrc found. Backing up to ${bak}..."
            cp "${target_home}/.zshrc" "${bak}"
        fi
        log_info "Deploying .zshrc to ${target_home}/.zshrc..."
        cp "${SOURCE_ZSHRC}" "${target_home}/.zshrc"
        chown "${target_user}:" "${target_home}/.zshrc"
    else
        log_warn "No .zshrc source found at ${SOURCE_ZSHRC}. Skipping .zshrc deployment."
    fi
}

# ============================================================
# SECTION 15: Set Zsh as Default Shell
# ============================================================
set_default_shell() {
    local zsh_path
    zsh_path="$(command -v zsh)"
    local target_user="${SUDO_USER:-${USER}}"

    if [[ "$(getent passwd "${target_user}" | cut -d: -f7)" != "${zsh_path}" ]]; then
        log_info "Setting default shell to ${zsh_path} for ${target_user}..."
        chsh -s "${zsh_path}" "${target_user}"
    else
        log_info "Default shell is already zsh for ${target_user}."
    fi
}

# ============================================================
# SECTION 16: Cleanup Package Cache
# ============================================================
cleanup() {
    log_info "==> Cleaning up package cache..."
    dnf clean all -q
}

# ============================================================
# SECTION 17: Completion Summary
# ============================================================
show_completion_summary() {
    echo ""
    echo "================================================================"
    echo " All done! Summary:"
    echo "   Removed:"
    echo "     - KDE games, multimedia thumbnailers"
    echo "     - KDE PIM / Office packages"
    echo "     - KDE settings packages"
    echo "     - Flatpak applications and runtime"
    echo "   Installed:"
    echo "     - Visual Studio Code (Microsoft native RPM)"
    echo "     - JetBrains Mono Nerd Font (/usr/local/share/fonts/JetBrainsMonoNF)"
    echo "     - ONLYOFFICE Desktop Editors (/usr/bin/desktopeditors)"
    echo "     - Zsh + autosuggestions, zsh-z, syntax-highlighting"
    echo "     - Starship prompt"
    echo "   Configured:"
    echo "     - DNF: max_parallel_downloads=10, fastestmirror=True"
    echo "     - .zshrc deployed from dotfiles"
    echo "     - Default shell set to zsh"
    if [[ -f "${BACKUP_FILE}" ]]; then
        echo ""
        echo "   Package backup: ${BACKUP_FILE}"
    fi
    echo "================================================================"
    log_info "Script completed successfully! Restart your terminal to use Zsh."
}

# ============================================================
# Main Execution Entry Point
# ============================================================
main() {
    check_root
    show_summary
    create_backup
    configure_dnf
    update_metadata
    remove_kde_games
    remove_multimedia
    remove_kde_pim
    remove_kde_settings
    remove_flatpak
    install_vscode
    install_fonts
    install_onlyoffice
    install_zsh
    install_starship
    deploy_zshrc
    set_default_shell
    cleanup
    show_completion_summary
}

main "$@"

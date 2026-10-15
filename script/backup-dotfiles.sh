#!/usr/bin/env bash
# ============================================================
# backup-dotfiles.sh — Sync local user configurations to dotfiles repo
# ============================================================

set -euo pipefail

# ------------------------------------------------------------
# Global Configuration & Paths
# ------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
DOTFILES_CONFIG="${REPO_ROOT}/config"

# Colors for formatted logging
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# ------------------------------------------------------------
# Logging Functions
# ------------------------------------------------------------
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# ------------------------------------------------------------
# Helper: Backup item with validation
# ------------------------------------------------------------
backup_item() {
    local src="$1"
    local dest="$2"
    local name="$3"

    if [[ ! -e "${src}" ]]; then
        log_warn "Skipping ${name}: '${src}' does not exist."
        return 0
    fi

    log_info "Backing up ${name}..."
    mkdir -p "$(dirname "${dest}")"
    rsync -ah --delete --progress "${src}" "${dest}"
}

# ------------------------------------------------------------
# Main Backup Routine
# ------------------------------------------------------------
main() {
    if ! command -v rsync &>/dev/null; then
        log_error "rsync is required but not installed. Please install rsync first."
        exit 1
    fi

    log_info "Target dotfiles config path: ${DOTFILES_CONFIG}"

    # Neovim
    backup_item "${HOME}/.config/nvim/" "${DOTFILES_CONFIG}/nvim/" "Neovim"

    # Fcitx5
    backup_item "${HOME}/.config/fcitx5/" "${DOTFILES_CONFIG}/fcitx5/" "Fcitx5"

    # Rofi
    backup_item "${HOME}/.config/rofi/" "${DOTFILES_CONFIG}/rofi/" "Rofi"

    # Alacritty
    backup_item "${HOME}/.config/alacritty/" "${DOTFILES_CONFIG}/alacritty/" "Alacritty"

    # Starship
    backup_item "${HOME}/.config/starship.toml" "${DOTFILES_CONFIG}/starship.toml" "Starship prompt"

    # Zsh configuration
    backup_item "${HOME}/.zshrc" "${DOTFILES_CONFIG}/.zshrc" "Zshrc"

    log_info "Dotfiles backup completed successfully!"
}

main "$@"

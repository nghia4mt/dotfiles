# dotfiles

_**My setup linux use daily**_

---

## Overview

| Component | Choice |
|---|---|
| Terminal | Alacritty |
| Shell | Zsh |
| Prompt | Starship |
| Editor | Neovim |
| Multiplexer | tmux |
| Theme | Monokai |
| OS | Fedora 44 KDE Plasma |

---

## Repository Structure

```
dotfiles/
├── README.md              ← This file
├── .gitignore
├── .zshrc                 ← Deployed to ~/.zshrc
├── config/
│   ├── alacritty/
│   │   ├── alacritty.toml
│   │   └── onedark.toml
│   ├── starship.toml
│   └── tmux/
│       └── tmux.conf      ← Deployed to ~/.config/tmux/tmux.conf
└── script/
    ├── fedora_install.sh ← Post-install setup script
    ├── setup_zsh.sh
    └── backup-dotfiles.sh
```

---

## Neovim

**Leader key:** `Space`

### General & Window Management

| Key | Action |
|---|---|
| `<C-h>` | Focus window left |
| `<C-j>` | Focus window down |
| `<C-k>` | Focus window up |
| `<C-l>` | Focus window right |
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Equal split sizes |
| `<leader>sx` | Close window |

### Buffer Navigation

| Key | Action |
|---|---|
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>x` | Close buffer |

### File & Search (Telescope)

| Key | Action |
|---|---|
| `<leader>e` | Toggle file explorer (Neo-tree) |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<C-j>` | Move selection next (Telescope) |
| `<C-k>` | Move selection previous (Telescope) |

### Editing

| Key | Action |
|---|---|
| `<A-j>` | Move line down |
| `<A-k>` | Move line up |
| `<A-j>` | Move selection down (visual) |
| `<A-k>` | Move selection up (visual) |
| `<C-/>` or `<C-_>` | Toggle comment |

### LSP (active on LspAttach)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format buffer |

### Completion (Insert Mode)

| Key | Action |
|---|---|
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm completion |
| `<Tab>` | Next item / expand snippet |
| `<S-Tab>` | Previous item / jump back |

### Misc

| Key | Action |
|---|---|
| `<leader>q` | Quit nvim |
| `<leader>s` | Save file |
| `<leader>bn` | New buffer |
| `<leader>bb` | Switch to alternate buffer |
| `<Esc>` | Clear search highlight |
| `<leader>mp` | Markdown preview |
| `<leader>ms` | Stop markdown preview |

---

## tmux

**Mode:** vi copy-mode · **Mouse:** on · **Base index:** 1 · **Escape time:** 0

### Pane Navigation

| Key | Action |
|---|---|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |

### Pane Resize

| Key | Action |
|---|---|
| `Left` | Resize pane left (5 cells) |
| `Down` | Resize pane down (5 cells) |
| `Up` | Resize pane up (5 cells) |
| `Right` | Resize pane right (5 cells) |

### Window & Config

| Key | Action |
|---|---|
| `x` | Kill window |
| `r` | Rename window |
| `R` | Reload config (`~/.config/tmux/tmux.conf`) |

### Copy Mode (vi)

| Key | Action |
|---|---|
| `v` | Begin selection |
| `y` | Copy to clipboard (xclip) |
| `MouseDragEnd1Pane` | Copy selection to clipboard |

---

## Zsh

Plugins: `zsh-syntax-highlighting` · `zsh-autosuggestions` · `zsh-z`

---

## Alacritty

Theme: One Dark

---

## Quick Start

```bash
# Run the post-install setup script
sudo bash script/fedora_install.sh

# Or set up only what you need
bash script/backup-dotfiles.sh
bash script/setup_zsh.sh
```

---

## Credits

- [LazyVim](https://github.com/LazyVim/LazyVim) — Neovim plugin inspiration
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) — JetBrains Mono Nerd Font
- [Starship](https://starship.rs/) — Cross-shell prompt

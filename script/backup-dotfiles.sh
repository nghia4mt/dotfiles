#!/bin/bash

DOTFILES="$HOME/dotfiles/config"
SYNC="rsync -ah --progress"

#Backup neovim
$SYNC ~/.config/nvim/ $DOTFILES/nvim/

#Backup fcitx5
$SYNC ~/.config/fcitx5/ $DOTFILES/fcitx5/

#Backup rofi
$SYNC ~/.config/rofi/ $DOTFILES/rofi/

#Backup alacritty
$SYNC ~/.config/alacritty/ $DOTFILES/alacritty/

#Backup .zshrc
$SYNC ~/.zshrc $DOTFILES/

#Backup starship
$SYNC ~/.config/starship.toml $DOTFILES/

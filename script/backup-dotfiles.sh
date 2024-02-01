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

# Backup i3wm
$SYNC ~/.config/i3 $DOTFILES/i3/
$SYNC ~/.config/i3status $DOTFILES/i3status/

cp -r ~/.config/starship.toml $DOTFILES

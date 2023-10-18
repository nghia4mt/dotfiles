#!/bin/bash

DOTFILES="$HOME/dotfiles/config"
SYNC="rsync -ah --progress"

#Backup neovim
$SYNC ~/.config/nvim/ $DOTFILES/nvim/

#Backup kitty
$SYNC ~/.config/kitty/ $DOTFILES/kitty/

#Backup hyprland
$SYNC ~/.config/hypr/ $DOTFILES/hypr/

#Backup fcitx5
$SYNC ~/.config/fcitx5/ $DOTFILES/fcitx5/

#Backup rofi
$SYNC ~/.config/rofi/ $DOTFILES/rofi/

#Backup waybar
$SYNC ~/.config/waybar/ $DOTFILES/waybar/

#Backup starship
cp -r ~/.config/starship.toml $DOTFILES

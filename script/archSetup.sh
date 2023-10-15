#!/bin/bash


# Install package
sudo pacman -S --noconfirm firefox pipewire wireplumber wireshark-qt kitty waybar tmux fcixt5 fcixt5-unikey rofi grim slurp thunar thunar-volman gvfs wget pavucontrol neovim npm nodejs unzip network-manager-applet blueman hyprpaper docker dbeaver starship wl-clipboard git

# Add group
sudo usermod -aG docker $USER
sudo usermod -aG wireshark $USER

# Install Jetbrains Mono Nerd Font
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip" -O $HOME/JetBrains-NF.zip
cd $HOME
unzip JetBrains-NF -d ./JetBrains-NF
sudo cp -r JetBrains-NF /usr/share/fonts
sudo fc-cache -f
rm -rf JetBrains*


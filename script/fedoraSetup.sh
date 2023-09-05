#!/bin/bash
echo "fastestmirror=true" | sudo tee -a /etc/dnf/dnf.conf
echo "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf
echo "deltarpm=1" | sudo tee -a /etc/dnf/dnf.conf
echo "ip_resolve=4" | sudo tee -a /etc/dnf/dnf.conf

# Update
sudo dnf update -y

# Debloat package
sudo dnf remove akregator flatpak* kamoso mediawriter elisa-player kmag \
kgpg qt5-qdbusviewer kcharselect kwalletmanager* kcolorchooser dragon \
kmines kmahjongg kpat kruler kmousetool kmouth kolourpaint konversation \
krdc kfind kaddressbook kmail kontact korganizer ktnef libreoffice-* kf5-akonadi-* dnfdragora \
-y

# Install package
sudo dnf install nmap flameshot kitty wireshark nodejs npm docker -y

sudo usermod -aG docker $USER

## Install nerd font
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip" -O $HOME/JetBrains-NF.zip
cd $HOME
unzip JetBrains-NF -d ./JetBrains-NF
sudo cp -r JetBrains-NF /usr/share/fonts
sudo fc-cache -f
rm -rf JetBrains*

sudo dnf autoremove -y

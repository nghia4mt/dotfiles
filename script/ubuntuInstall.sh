#!/bin/bash

## Remove debloat
sudo apt remove -y kde-spectacle flatpak kate skanlite vlc kwalletmanager xed \
plasma-vault haruna net-tools ufw plasma-firewall kup-backup celluloid hypnotix

## Remove snapd
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service
sudo snap remove firefox
sudo apt autoremove --purge snapd -y
sudo rm -rf /var/cache/snapd/
rm -rf ~/snap

##Install firefox without snapd
echo "Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1" | sudo tee -a /etc/apt/preferences.d/firefox-no-snap
sudo add-apt-repository ppa:mozillateam/ppa -y
sudo apt install firefox -y

##Install Package
sudo apt install -y mpv wireshark docker.io nmap kitty tmux flameshot rofi openjdk-19-jdk openjdk-19-jre-headless nodejs npm dkms fcitx5 fcitx5-unikey

sudo usermod -aG wireshark $USER
sudo usermod -aG docker $USER
sudo usermod -aG vboxusers $USER

## Install vscode
wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
chmod +x vscode.deb
sudo apt install -y ./vscode.deb

## Install sublime-text-4
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update -y
sudo apt-get install sublime-text -y

## Install google-chome-stable
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update -y
sudo apt install google-chrome-stable -y

## Install neovim
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update -y
sudo apt-get install neovim -y

## Install nerd font
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip" -O $HOME/JetBrains-NF.zip
cd $HOME
unzip JetBrains-NF -d ./JetBrains-NF
sudo cp -r JetBrains-NF /usr/share/fonts
sudo fc-cache -f
rm -rf JetBrains*

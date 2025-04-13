#!/bin/bash

## Remove debloat
sudo apt remove -y kde-spectacle flatpak kate skanlite vlc kwalletmanager plasma-vault haruna net-tools ufw plasma-firewall kup-backup celluloid orca

## Remove snapd
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service
sudo snap remove firefox
sudo apt autoremove --purge snapd -y
sudo rm -rf /var/cache/snapd/
rm -rf ~/snap

##Install Package
sudo apt install -y mpv wireshark nmap alacritty tmux flameshot rofi dkms fcitx5 fcitx5-bamboo xsel zoxide wget
sudo usermod -aG wireshark $USER

##Install firefox without snapd
sudo install -d -m 0755 /etc/apt/keyrings 
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla 
sudo apt-get update -y && sudo apt-get install firefox -không

##Install google-chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb


## Install vscode
wget -O $HOME/vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
cd $HOME
chmod +x vscode.deb
sudo apt install -y ./vscode.deb
sudo rm -rf vscode.deb

## Install sublime-text-4
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update -y
sudo apt-get install sublime-text -y

## Install nerd font
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip" -O $HOME/JetBrains-NF.zip
cd $HOME
unzip JetBrains-NF -d ./JetBrains-NF
sudo cp -r JetBrains-NF /usr/share/fonts
sudo fc-cache -f
rm -rf $HOME/JetBrains*

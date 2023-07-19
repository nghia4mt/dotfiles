#!/bin/bash
download_yay='
	mkdir -p $HOME/repo
	cd $HOME/repo
	git clone https://aur.archlinux.org/yay-bin.git
	cd yay-bin
	makepkg -si --noconfirm'

# Step Setup
sudo pacman -Syu --noconfirm

# config yay
if [ -x /usr/bin/yay ]; then
	printf "yay installed"
else
	$download_yay
fi
rm -rf $HOME/repo

yay -S --noconfirm cronie dbeaver dkms docker firefox flameshot git google-chrome ibus ibus-bamboo kitty linux-headers neovim net-tools nmap nodejs noto-fonts-emoji npm pacman-contrib ripgrep rsync shfmt sublime-text-4 tmux yarn visual-studio-code-bin mpv wget wireshark-qt xsel obsidian jdk-openjdk dropbox

sudo usermod -aG docker $USER
sudo usermod -aG wireshark $USER

# Install Fonts
if [ -d $HOME/.local/share/fonts/ ]; then
	printf "Folder exist"
else
	mkdir -p $HOME/.local/share/fonts/
fi

# copy file config
cp -r ../config/* ~/.config/

# Ibus-bamboo
textbamboo='
# Ibus-bamboo
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus
ibus-daemon -drx'

if grep -Fxq "$textbamboo" /etc/profile
then
	echo "code found"
else
	echo "$textbamboo" | sudo tee -a /etc/profile
fi

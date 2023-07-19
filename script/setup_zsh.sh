#/bin/bash
sudo apt install curl zsh -y
cp -r ../.zshrc ~/
mkdir ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/agkozak/zsh-z ~/.zsh/zsh-z
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
chsh -s $(which zsh)

# Auto start tmux
if [ -z "$TMUX" ]
then
    tmux attach -t ngmt || tmux new -s ngmt
fi

autoload -U colors && colors
autoload -U compinit && compinit
zstyle ':completion:*' menu select
bindkey -e
tmux source ~/.config/tmux/tmux.conf

# Plugins
plugins=( 
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-z
    )

eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
source ~/.zsh/zsh-z/zsh-z.plugin.zsh


#########################################################################################
################################### Alias ###############################################
alias rl="source ~/.zshrc"

# Quick Edit
alias et='nvim ~/.config/tmux/tmux.conf'
alias dow="cd ~/Downloads ; ls"
alias ez='nvim ~/.zshrc'
alias ...="cd ../.."
alias ..="cd .."
alias v="nvim"
alias l="ls -lah"
alias c="clear"
alias ls="ls --color=auto"
alias shut="shutdown now"

# Confirm
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

# Alias git
alias gs="git status"
alias gst="git status -sb"
alias g="git"
alias gcm="git commit -m"
alias ga="git add"
alias gaa="git add ."
alias gl="git pull"
alias gp="git push"
alias gcl="git clone"

# Alias systemctl
alias st-start="sudo systemctl start"
alias st-stop="sudo systemctl stop"
alias st-restart="sudo systemctl restart"
alias st-status="sudo systemctl status"
alias st-enable="sudo systemctl enable"
alias st-disable="sudo systemctl disable"

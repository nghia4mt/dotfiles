# Auto start tmux
if [ -z "$TMUX" ]
then
    tmux attach -t tmn || tmux new -s tmn
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
	. /usr/share/bash-completion/bash_completion

#######################################################################
########################### Alias #####################################
alias rl="source ~/.bashrc"

# Quick Edit
alias ek='nvim ~/.config/kitty/kitty.conf'
alias et='nvim ~/.config/tmux/tmux.conf'
alias dow="cd ~/Downloads ; ls"
alias eb='nvim ~/.bashrc'
alias ...="cd ../.."
alias ..="cd .."
alias l="ls -lah"
alias ls='ls --color=auto'
alias +x='chmod +x'
alias mv="mv - i"
alias cp="cp -i"

# Alias git
alias gst="git status"
alias g="git"
alias gcm="git commit -m"
alias ga="git add"
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

alias v="nvim"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/tmn/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/tmn/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/tmn/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/tmn/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


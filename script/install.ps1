New-Item -Path $profile -ItemType "file" -Force
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
scoop install git
scoop update
scoop bucket add nerd-fonts
scoop bucket add extras



scoop install nerd-fonts/JetBrains-Mono
scoop install scoop-completion
scoop install main/scoop-search
scoop install extras/dockercompletion

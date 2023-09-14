# enable completion in current shell, use absolute path because PowerShell Core not respect $env:PSModulePath
Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
Invoke-Expression (&scoop-search --hook)
Import-Module DockerCompletion
Set-Alias -Name subl -Value "D:\Apps\windows\sublime_text\subl.exe"

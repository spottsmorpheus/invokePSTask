Write-Host "This is and Example Powershell Cmd Script executing from a Git Url"
Write-Host ""
Write-Host "Executing on $([Environment]::MachineName) - User $([Environment]::UserName)"
Write-Host "Command Line: $([Environment]::CommandLine)"
# Signal a good exit
Return 0
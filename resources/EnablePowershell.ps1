#This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $arguments = "&" + $MyInvocation.MyCommand.Definition + "" 
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator." -ForegroundColor "White"
    Start-Sleep 1
    Start-Process "powershell.exe" -Verb RunAs -ArgumentList $arguments
    Break
}

Set-ExecutionPolicy Unrestricted
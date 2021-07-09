$ErrorActionPreference = "Stop"


Write-Host "Activating WSL features."
Write-Host "THE COMPUTER WILL RESTART IF FEATURES ARE NOT INSTALLED. RUN THIS SCRIPT AGAIN IF THAT IS THE CASE."
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# Install WSL

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all

# Computer will be restarted here if the above features was not installed.


cmd /c start /wait msiexec.exe /i https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi /quiet /norestart

wsl --set-default-version 2


# Install Ubuntu for WSL

Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-2004 -OutFile ubuntu.appx -UseBasicParsing

Add-AppxPackage .\ubuntu.appx


# Install Chocolatey

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


# Install Docker Desktop

choco install docker-desktop -y

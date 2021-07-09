$ErrorActionPreference = "Stop"

# Install WSL

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Start-Process -wait msiexec.exe /i https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi /quiet /qn /norestart

wsl --set-default-version 2


# Install Ubuntu for WSL

Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-2004 -OutFile ubuntu.appx -UseBasicParsing

Add-AppxPackage .\ubuntu.appx


# Install Chocolatey

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


# Install Docker Desktop

choco install docker-desktop -y

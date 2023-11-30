# Copilot Q: add command to install chocolatey on windows from Powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Function Install-ChocoPackages {
  param (
    [Parameter(Mandatory=$true)]
    [string[]]$Packages
  )

  foreach ($package in $Packages) {
    choco install $package -y
  }
}

$packages = [System.Collections.Generic.HashSet[string]]@(
  "wireshark",
  "thunderbird",
  "postman",
  "azure-functions-core-tools",
  "adobereader",
  "googlechrome",
  "notepadplusplus",
  "zoomit",
  "git",
  "gh",
  "azure-cli",
  "microsoftazurestorageexplorer",
  "jdk8",
  "wsl",
  "wireshark",
  "thunderbird",
  "docker-desktop",
  "postman",
  "azure-functions-core-tools  --params='/x64:true'",
  "terrafrom",
  "python3",
  "azure-data-studio",
  "visioviewer"
)

Install-ChocoPackages -Packages $packages

wsl --set-default-version 2
# choco install wsl-ubuntu-2204
Install-ChocoPackages -Packages @("wsl-ubuntu-2204")

# choco install intellijidea-community
# choco install onedrive
# choco install office365business
# choco install kubernetes-helm --version=3.0.2
# choco install nodejs-lts --version=10.16.0

# Already in DevBox image:
# choco install azure-functions-core-tools-3
# choco install visualstudio2019enterprise
# choco install visualstudio2022enterprise
# choco install wsl-ubuntu-2004 --params "/InstallRoot:true"

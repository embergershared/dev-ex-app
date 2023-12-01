# Log will be here: C:\ProgramData\chocolatey\logs\chocolatey.log

# 1. Install Chocolatey
# Copilot Q: add command to install chocolatey on windows from Powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# 2. Load functions
Function Install-ChocoPackages {
  param (
    [Parameter(Mandatory=$true)]
    [string[]]$Packages
  )

  foreach ($package in $Packages) {
    choco install $package -y
  }
}
Function Uninstall-ChocoPackages {
  param (
    [Parameter(Mandatory=$true)]
    [string[]]$Packages
  )

  foreach ($package in $Packages) {
    choco uninstall $package -y
  }
}

# 3. Unistall packages that are in the image but defective after sysprep
$uninstall_packages = @(
  "docker-desktop"
  # "notepadplusplus"
)
Uninstall-ChocoPackages -Packages $uninstall_packages

# 4. Install packages
$install_packages = @(
  "wireshark",
  "thunderbird",
  "postman",
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
  "azure-functions-core-tools --params='/x64:true'",
  "terrafrom",
  "python3",
  "azure-data-studio",
  "visioviewer"
)
Install-ChocoPackages -Packages $install_packages

# 5. Set WSL to v2
wsl --set-default-version 2

# 6. Install Ubuntu 22.04 distro in WSL
Install-ChocoPackages -Packages @("wsl-ubuntu-2204")

# 7. Display installed packages
choco list

# 8. Displaying end of script
Write-Host "Script choco-install.ps1 ended"

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

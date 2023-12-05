Write-Host "==>  Script 1-install-tooling.ps1 STARTED  < =="
Write-Host
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
    $command = "choco install $package -y"
    Write-Host
    Write-Host "Install-ChocoPackages => Executing: $command"
    Invoke-Expression $command
  }
}
Function Upgrade-ChocoPackages {
  param (
    [Parameter(Mandatory=$true)]
    [string[]]$Packages
  )

  foreach ($package in $Packages) {
    $command = "choco upgrade $package -y"
    Write-Host
    Write-Host "Upgrade-ChocoPackages => Executing: $command"
    Invoke-Expression $command
  }
}
Function Uninstall-ChocoPackages {
  param (
    [Parameter(Mandatory=$true)]
    [string[]]$Packages
  )

  $installed=$(choco list)

  foreach ($package in $Packages) {
    if($installed -match $package) {
      $command = "choco uninstall $package -y"
      Write-Host
      Write-Host "Uninstall-ChocoPackages => Executing: $command"
      Invoke-Expression $command
    }
  }
}

# # 3. Unistall packages that are in the image but defective after sysprep
# $uninstall_packages = @(
#   # "docker-desktop"
#   "notepadplusplus"
# )
# Uninstall-ChocoPackages -Packages $uninstall_packages

# 4. Install packages

# We start with Google chrome as it errors out if installed with other packages
Install-ChocoPackages -Packages "googlechrome --ignore-checksums"

# Then install the rest of the packages
$install_packages = @(
  "wireshark",
  "thunderbird",
  "postman",
  "adobereader",
  "firefox",
  "notepadplusplus",
  "zoomit",
  "git",
  "gh",
  "azure-cli",
  "vscode",
  "sysinternals",
  "microsoftazurestorageexplorer",
  "jdk8",
  "wireshark",
  "thunderbird",
  "docker-desktop",
  "postman",
  "azure-functions-core-tools --params='/x64:true'",
  "terraform",
  "python3",
  "azure-data-studio",
  "kubectx",
  "kubens",
  "kubernetes-cli",
  "kubernetes-helm",
  "krew",
  "flux",
  "argocd-cli",
  "visioviewer"
)
Install-ChocoPackages -Packages $install_packages

$upgrade_packages = @(
  "visualstudio2022enterprise"
)
Upgrade-ChocoPackages -Packages $upgrade_packages

# 5. Install Ubuntu 22.04 distro in WSL
wsl --set-default-version 2
wsl --install -d Ubuntu-22.04
wsl -l -v

# 6. Display installed packages
choco list

# 7. Displaying end of script
Write-Host
Write-Host "==>  Script 1-install-tooling.ps1 ENDED  <=="

# 8. Display Restart message
Write-Host
Write-Host "***  RESTART the Dev box to setup Docker Desktop  ***"
Write-Host "***     Restart : 'Restart-Computer'  ***"
Write-Host "***     Shutdown: 'Stop-Computer'     ***"


# == Potential additional packages:
# choco install intellijidea-community
# choco install onedrive
# choco install office365business
# choco install kubernetes-helm --version=3.0.2
# choco install nodejs-lts --version=10.16.0

# == Already in DevBox image custom:
# choco install visualstudio2019enterprise
# choco install visualstudio2022enterprise
# choco install wsl-ubuntu-2004 --params "/InstallRoot:true"

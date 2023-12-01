Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install adobereader
choco install googlechrome
choco install notepadplusplus
choco install zoomit
choco install git
choco install azure-cli
choco install azure-functions-core-tools
choco install microsoftazurestorageexplorer
choco install visualstudio2022enterprise
choco install jdk8
choco install wsl
wsl --set-default-version 2
choco install wireshark
choco install wsl-ubuntu-2204
choco install thunderbird
choco install docker-desktop 
choco install postman

# choco install python3
# choco install intellijidea-community
# choco install onedrive
# choco install office365business
# choco install azure-data-studio
# choco install azure-functions-core-tools-3
# choco install visualstudio2019enterprise
# choco install visioviewer
# choco install wsl-ubuntu-2004 --params "/InstallRoot:true" 
# choco install docker-desktop 
# choco install kubernetes-helm --version=3.0.2
# choco install nodejs-lts --version=10.16.0
# choco install terraform
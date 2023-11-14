# New developer setup

## Hello!


## Get started

Here is a PowerShell script that will get you started with our WebApp (runs as Admin to set the environment variable):
```powershell
# Set script values
$folderPath = "$HOME\source\repos\github\embergershared"
$repoName="dev-ex-app"
$visualStudioPath = "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\devenv.exe"
$repoPath = "$folderPath\$repoName"
$solutionFilePath = "$repoPath\src\ContosoUniversity.sln"
$webApiSettingsPath = "$repoPath\src\ContosoUniversity.API\appsettings.json"

# Create the organization repos folder
if (!(Test-Path $folderPath)) { New-Item -Path $folderPath -ItemType Directory -Force }
Set-Location -Path $folderPath

# clone the project repo
git clone https://github.com/embergershared/$repoName.git

# Connect to Azure AD
az login

# Set git user name & email (from Azure AD)
git config --global user.name "$(az ad signed-in-user show --query 'displayName' -o tsv)"
git config --global user.email "$(az ad signed-in-user show --query 'userPrincipalName' -o tsv)"

# Create a SQL Server container to start development
docker pull mcr.microsoft.com/mssql/server:2022-latest
$pw = Read-Host "SQL container SA account password to use: " -AsSecureString
docker run `
   -e "ACCEPT_EULA=Y" `
   -e "MSSQL_SA_PASSWORD=$([pscredential]::new('user',$pw).GetNetworkCredential().Password)" `
   -p 1433:1433 --name local-sql --hostname sql `
   -d `
   mcr.microsoft.com/mssql/server:2022-latest

# Update Web API connection string
((Get-Content -path $webApiSettingsPath -Raw) -replace '<pwd>', [pscredential]::new('user',$pw).GetNetworkCredential().Password) | Set-Content -Path $webApiSettingsPath

# launch Visual Studio
Start-Process -FilePath $visualStudioPath -ArgumentList $solutionFilePath
```
# New developer setup

## Hello!


## Get started

To get started, once connected to your DevBox, execute the script below in a Terminal.
It will:

- Clone the application code on the DevBox,
- Log you in in Azure (use the same account used to log in your DexBox),
- Generate basics `git` settings for your commits,
- Ask you to define a SQL Server administrator account,
- Create a Microsoft SQL Server 2022 container for your dev database,
- Wire the settings in the application for it to run right-away,
- Launch Visual Studio on our App solution.

Use this PowerShell script:

```powershell
# Set script values
$folderPath = "$HOME\source\repos\github\embergershared"
$repoName="dev-ex-app"
$visualStudioPath = "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\devenv.exe"
$repoPath = "$folderPath\$repoName"
$solutionFilePath = "$repoPath\src\ContosoUniversity.sln"
$webApiSettingsPath = "$repoPath\src\ContosoUniversity.API\appsettings.json"

# Create the GitHub organization folder
if (!(Test-Path $folderPath)) { New-Item -Path $folderPath -ItemType Directory -Force }
Set-Location -Path $folderPath

# Clone the project repo
git clone https://github.com/embergershared/$repoName.git

# Connect to Azure
az login

# Set git user name & email (using Azure AD)
git config --global user.name "$(az ad signed-in-user show --query 'displayName' -o tsv)"
git config --global user.email "$(az ad signed-in-user show --query 'userPrincipalName' -o tsv)"

# Create a SQL Server container for development
docker pull mcr.microsoft.com/mssql/server:2022-latest
$pw = Read-Host "SQL container SA account password to use: " -AsSecureString
docker run `
   -e "ACCEPT_EULA=Y" `
   -e "MSSQL_SA_PASSWORD=$([pscredential]::new('user',$pw).GetNetworkCredential().Password)" `
   -p 1433:1433 --name local-sql --hostname sql `
   -d `
   mcr.microsoft.com/mssql/server:2022-latest

# Update Web API connection string with SQL server sa account password
((Get-Content -path $webApiSettingsPath -Raw) -replace '<pwd>', [pscredential]::new('user',$pw).GetNetworkCredential().Password) | Set-Content -Path $webApiSettingsPath

# Launch Visual Studio
Start-Process -FilePath $visualStudioPath -ArgumentList $solutionFilePath
```

# Set script values
$folderPath = "$HOME\source\repos\github\embergershared"
$repoName = "dev-ex-app"
$visualStudioPath = "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\devenv.exe"
$repoPath = "$folderPath\$repoName"
$solutionFilePath = "$repoPath\src\ContosoUniversity.sln"
$webApiDevSettingsFile = "src\ContosoUniversity.API\appsettings.Development.json"
$webApiDevSettingsPath = "$repoPath\$webApiDevSettingsFile"

# Create the GitHub organization folder
if (!(Test-Path $folderPath)) { New-Item -Path $folderPath -ItemType Directory -Force }
Set-Location -Path $folderPath

# Clone the project repo
git clone https://github.com/embergershared/$repoName.git
Set-Location $repoPath

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
git update-index --assume-unchanged $webApiDevSettingsFile # revert with: git update-index --no-assume-unchanged $webApiDevSettingsFile
((Get-Content -path $webApiDevSettingsPath -Raw) -replace 'ContosoUniversityAPIContextDevValue', "Server=localhost,1433; Database=ContosoUniversity; User Id=sa; Password=$([pscredential]::new('user', $pw).GetNetworkCredential().Password);MultipleActiveResultSets=true;TrustServerCertificate=true;") | Set-Content -Path $webApiDevSettingsPath

# Launch Visual Studio
Start-Process -FilePath $visualStudioPath -ArgumentList $solutionFilePath

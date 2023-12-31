# Functions
Function Test-MeetsMsSqlPasswordRequirements {
  param(
      [Parameter(Mandatory=$true)]
      [System.Security.SecureString]$Password
  )

  $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)
  $PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

  # Check if password length is at least 8 characters
  if ($PlainPassword.Length -lt 8) {
      Write-Host "Password must be at least 8 characters long."
      return $false
  }

  # Check if password contains at least one uppercase letter
  if (-not ($PlainPassword -cmatch '[A-Z]')) {
      Write-Host "Password must contain at least one uppercase letter."
      return $false
  }

  # Check if password contains at least one lowercase letter
  if (-not ($PlainPassword -cmatch '[a-z]')) {
      Write-Host "Password must contain at least one lowercase letter."
      return $false
  }

  # Check if password contains at least one digit
  if (-not ($PlainPassword -cmatch '\d')) {
      Write-Host "Password must contain at least one digit."
      return $false
  }

  # Check if password contains at least one special character
  if (-not ($PlainPassword -cmatch '[^a-zA-Z\d]')) {
      Write-Host "Password must contain at least one special character."
      return $false
  }

  # Check if the password contains any of the disallowed characters (; for connection string)
  if ($PlainPassword -cmatch ";") {
    Write-Host "Password must not contain: ;."
    return $false
  }

  # If all checks passed, return true
  return $true
}

# Set script values
$orgName = "embergershared"
$repoName = "dev-ex-app"

$folderPath = "$HOME\source\repos\github\$orgName"
$repoPath = "$folderPath\$repoName"
$webApiDevSettingsFile = "src\ContosoUniversity.API\appsettings.Development.json"
$webApiDevSettingsPath = "$repoPath\$webApiDevSettingsFile"
$solutionFilePath = "$repoPath\src\ContosoUniversity.sln"
$visualStudioPath = "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\IDE\devenv.exe"


# Clone the application repo
# Create the GitHub organization folder
if (!(Test-Path $folderPath)) {
  New-Item -Path $folderPath -ItemType Directory -Force
} else {
  Remove-Item -Path $folderPath -Recurse -Force
  New-Item -Path $folderPath -ItemType Directory -Force
}
Set-Location -Path $folderPath

# Clone the project repo
git clone https://github.com/$orgName/$repoName.git
Set-Location $repoPath

# Connect to Azure
az login

# Set git user name & email (using Azure AD)
git config --global user.name "$(az ad signed-in-user show --query 'displayName' -o tsv)"
git config --global user.email "$(az ad signed-in-user show --query 'userPrincipalName' -o tsv)"

# Create a SQL Server container for development
docker pull mcr.microsoft.com/mssql/server:2022-latest
# Request a password for the SQL Server sa account
$attempts = 0; $maxAttempts = 3
while ($attempts -lt $maxAttempts) {
  $pw = Read-Host "Enter a password for the SQL container SA account" -AsSecureString

  if (Test-MeetsMsSqlPasswordRequirements -Password $pw) {
    break
  }
  $attempts++

  if ($attempts -eq $maxAttempts) {
    Write-Host "Maximum number of attempts ($maxAttempts) reached. Exiting script."
    return
  }
}

# Check if container aldready exists with the same name and remove it
$containerName = "local-sql"
if (docker ps -a --format '{{.Names}}' | Select-String -Pattern $containerName) {
  docker rm -f $containerName
}
# Create a new container
docker run `
  -e "ACCEPT_EULA=Y" `
  -e "MSSQL_SA_PASSWORD=$([pscredential]::new('user',$pw).GetNetworkCredential().Password)" `
  -p 1433:1433 --name $containerName --hostname sql `
  -d `
  mcr.microsoft.com/mssql/server:2022-latest
  $containerName = "local-sql"

# Update Web API connection string with SQL server sa account password
git update-index --assume-unchanged $webApiDevSettingsFile # To revert: git update-index --no-assume-unchanged $webApiDevSettingsFile
((Get-Content -path $webApiDevSettingsPath -Raw) -replace 'ContosoUniversityAPIContextDevValue', "Server=localhost,1433;Database=ContosoUniversity;User Id=sa;Password=$([pscredential]::new('user', $pw).GetNetworkCredential().Password);MultipleActiveResultSets=true;TrustServerCertificate=true;") | Set-Content -Path $webApiDevSettingsPath

# Launch Visual Studio 2022
Start-Process -FilePath $visualStudioPath -ArgumentList $solutionFilePath

# Close the PowerShell window
exit
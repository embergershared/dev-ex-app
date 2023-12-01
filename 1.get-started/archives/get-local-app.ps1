# Set script values
$orgName = "embergershared"
$repoName = "dev-ex-app"

$folderPath = "$HOME\source\repos\github\$orgName"
$repoPath = "$folderPath\$repoName"

# Create the GitHub organization folder
if (!(Test-Path $folderPath)) { New-Item -Path $folderPath -ItemType Directory -Force }
Set-Location -Path $folderPath

# Clone the project repo
git clone https://github.com/$orgName/$repoName.git
Set-Location $repoPath

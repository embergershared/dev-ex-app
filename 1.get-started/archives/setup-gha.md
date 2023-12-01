# This script generates the variables and secrets to deploy the Infra, then the app with Github Actions workflows

## Requirements

- github cli: [GH CLI Installation](https://github.com/cli/cli#installation)

## GitHub CLI setup/start

```powershell
# on Windows:
choco install gh

# Set the organization and repo to use
Set-Location .. # Move your prompt in the root of the GH cloned repo

# Login to Github
gh auth login
# Check your login
gh auth status
# Check your set on the right repo
gh repo set-default
```

### Create Environments

Environments have to be created in the UI. There are no `gh cli` commands to create them (yet).

### Create Variables & Secrets

The required Variables/Secrets to deploy with Github Actions are:

- `AZ_ENVIRONMENT_NAME`
- `AZ_LOCATION`
- `AZ_SQL_SERVER_PASSWORD`
- `AZ_APP_PASSWORD`

- `AZURE_SUBSCRIPTION_ID`
- `AZURE_TENANT_ID`
- `AZURE_GHA_CLIENT_ID`

> - `AZURE_CREDENTIALS`

#### At repository level

```powershell
# Variables
gh variable set AZURE_LOCATION --body "eastus2"
gh variable set AZURE_SUBSCRIPTION_ID --body "a73ced30-c712-4405-8828-67a833b1e39a"

# Secrets
gh secret set AZURE_SQL_PASSWORD --body "eastus2" --app actions

```

#### At environment level

##### Dev environment

```powershell
gh variable set AZURE_ENVIRONMENT_NAME --env dev --body "devexday-demo-dev"
```

##### UAT environment

```powershell
gh variable set AZURE_ENVIRONMENT_NAME --env dev --body "devexday-demo-uat"
```


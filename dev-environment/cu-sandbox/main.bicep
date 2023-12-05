// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

// Dev environment deployment update:
// - Execute to update the ARM template created from this bicep file:
// az bicep build --file main.bicep --outfile azuredeploy.json
// - Commit changes to main
// - Sync catalog (https://portal.azure.com/#@mngenvmcap912772.onmicrosoft.com/resource/subscriptions/a73ced30-c712-4405-8828-67a833b1e39a/resourceGroups/rg-use2-912772-s1-devexdays-demos-01/providers/Microsoft.DevCenter/devcenters/dc-org-alpha-eastus2-01/template_repository)


// ===============   Parameters   ===============
@description('Name of the Web App')
param name string = ''

@description('Location to deploy the environment resources')
param location string = resourceGroup().location

@description('Tags to apply to environment resources')
param tags object = {}
param scmDoBuildDuringDeployment bool = false
param appSettings object = {}
param enableOryxBuild bool = true

// ===============   Variables   ===============
var resourceName = !empty(name) ? replace(name, ' ', '-') : 'a${uniqueString(resourceGroup().id)}'

var hostingPlanName = 'appsvcplan-${resourceName}'
var kind = 'app,linux'
var linuxFxVersion = 'dotnetcore|6.0'
var webAppName = 'app-${resourceName}'
var webApiName = 'api-${resourceName}'
var sqlServerName = 'sql-${resourceName}'
var keyVaultName = 'kv-${take(replace(resourceName, '-', ''), 21)}'
var lawName = 'law-${resourceName}'
var appInsightsName = 'appi-${resourceName}'
var sqlAdmin = 'sqladmin'
var sqlAdminPassword = '${uniqueString(keyVaultName)}Up!P1'
var appUser = 'appUser'
var appUserPassword = 'iT$23${uniqueString(sqlAdminPassword)}'
var databaseName = 'ContosoUniversity'
var connectionString = 'Server=${sqlServer.properties.fullyQualifiedDomainName}; Database=${sqlServer::database.name}; User=${appUser}'

// ===============   Resources   ===============
//  / App Service Plan
resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: hostingPlanName
  location: location
  kind: 'linux'
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
  tags: tags
}
//  / App Service Web APP
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  kind: kind
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      linuxFxVersion: 'dotnetcore|6.0'
      alwaysOn: true
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
      use32BitWorkerProcess: false
      healthCheckPath: '/healthz'
    }
    clientAffinityEnabled: false
    httpsOnly: true
  }

  identity: { type: 'SystemAssigned' }

  resource configAppSettings 'config' = {
    name: 'appsettings'
    properties: union(appSettings,
      {
        SCM_DO_BUILD_DURING_DEPLOYMENT: string(scmDoBuildDuringDeployment)
        ENABLE_ORYX_BUILD: string(enableOryxBuild)
      },
      !empty(applicationInsights.name) ? { APPLICATIONINSIGHTS_CONNECTION_STRING: applicationInsights.properties.ConnectionString } : {},
      !empty(keyVaultName) ? { AZURE_KEY_VAULT_ENDPOINT: keyVault.properties.vaultUri } : {},
      {
        ASPNETCORE_ENVIRONMENT: 'Development'
        URLAPI: 'https://${webApi.properties.defaultHostName}'
      }
    )
  }

  tags: tags
}
resource webAppScm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  name: 'scm'
  kind: 'string'
  parent: webApp
  properties: {
    allow: true
  }
}
resource webAppFtp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  name: 'ftp'
  kind: 'string'
  parent: webApp
  properties: {
    allow: true
  }
}
//  / App Service Web API
resource webApi 'Microsoft.Web/sites@2022-03-01' = {
  name: webApiName
  location: location
  kind: kind
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: true
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
      use32BitWorkerProcess: false
      healthCheckPath: '/healthz'
    }
    clientAffinityEnabled: false
    httpsOnly: true
  }

  identity: { type: 'SystemAssigned' }

  resource configAppSettings 'config' = {
    name: 'appsettings'
    properties: union(appSettings,
      {
        ASPNETCORE_ENVIRONMENT: 'Development'
        AZURE_SQL_CONNECTION_STRING_KEY: 'AZURE-SQL-CONNECTION-STRING'
      }
    )
  }

  tags: tags
}
resource webApiScm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  name: 'scm'
  kind: 'string'
  parent: webApi
  properties: {
    allow: true
  }
}
resource webApiFtp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  name: 'ftp'
  kind: 'string'
  parent: webApi
  properties: {
    allow: true
  }
}

//  / Key vault and secrets
resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyVaultName
  location: location
  tags: tags
  properties: {
    tenantId: subscription().tenantId
    sku: { family: 'A', name: 'standard' }
    accessPolicies: []
    enableRbacAuthorization: true
  }
}
resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  name: 'SqlAdminPassword'
  tags: tags
  parent: keyVault
  properties: {
    attributes: {
      enabled: true
      exp: 0
      nbf: 0
    }
    value: sqlAdminPassword
  }
}
resource sqlAzureConnectionStringSercret 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  parent: keyVault
  name: 'AZURE-SQL-CONNECTION-STRING'
  properties: {
    value: '${connectionString}; Password=${sqlAdminPassword}'
  }
}

//  / Azure SQL Server and Database
resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  tags: tags
  properties: {
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    administratorLogin: sqlAdmin
    administratorLoginPassword: sqlAdminPassword
  }

  resource database 'databases' = {
    name: databaseName
    location: location
    sku: {
      name: 'GP_S_Gen5'
      tier: 'GeneralPurpose'
      family: 'Gen5'
      capacity: 2
    }
    properties: {
      collation: 'SQL_Latin1_General_CP1_CI_AS'
      maxSizeBytes: 34359738368
      catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
      zoneRedundant: false
      readScale: 'Disabled'
      autoPauseDelay: 60
      requestedBackupStorageRedundancy: 'Local'
      minCapacity: json('0.5')
      isLedgerOn: false
    }
  }
}
resource sqlDeploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: '${name}-deployment-script'
  location: location
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.37.0'
    retentionInterval: 'PT1H' // Retain the script resource for 1 hour after it ends running
    timeout: 'PT5M' // Five minutes
    cleanupPreference: 'OnSuccess'
    environmentVariables: [
      {
        name: 'APPUSERNAME'
        value: appUser
      }
      {
        name: 'APPUSERPASSWORD'
        secureValue: appUserPassword
      }
      {
        name: 'DBNAME'
        value: databaseName
      }
      {
        name: 'DBSERVER'
        value: sqlServer.properties.fullyQualifiedDomainName
      }
      {
        name: 'SQLCMDPASSWORD'
        secureValue: sqlAdminPassword
      }
      {
        name: 'SQLADMIN'
        value: sqlAdmin
      }
    ]

    scriptContent: '''
wget https://github.com/microsoft/go-sqlcmd/releases/download/v0.8.1/sqlcmd-v0.8.1-linux-x64.tar.bz2
tar x -f sqlcmd-v0.8.1-linux-x64.tar.bz2 -C .

cat <<SCRIPT_END > ./initDb.sql
drop user ${APPUSERNAME}
go
create user ${APPUSERNAME} with password = '${APPUSERPASSWORD}'
go
alter role db_owner add member ${APPUSERNAME}
go
SCRIPT_END

./sqlcmd -S ${DBSERVER} -d ${DBNAME} -U ${SQLADMIN} -i ./initDb.sql
    '''
  }
}

//  / Log Analytics Workspace
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: lawName
  location: location
  tags: tags
  properties: any({
    retentionInDays: 30
    features: {
      searchVersion: 1
    }
    sku: {
      name: 'PerGB2018'
    }
  })
}

//  / Application Insights
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
  }
}

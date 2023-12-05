// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

// Parameters
@description('Name of the Web App')
param name string = ''

@description('Location to deploy the environment resources')
param location string = resourceGroup().location

@description('Tags to apply to environment resources')
param tags object = {}
param scmDoBuildDuringDeployment bool = false
param appSettings object = {}
param kind string = 'app,linux'
param enableOryxBuild bool = contains(kind, 'linux')


// Variables
var resourceName = !empty(name) ? replace(name, ' ', '-') : 'a${uniqueString(resourceGroup().id)}'

var hostingPlanName = 'appsvcplan-${resourceName}'
var webAppName = 'web-${resourceName}'
var webApiName = 'api-${resourceName}'
var sqlServerName = 'sql-${resourceName}'
var keyVaultName = 'kv-${take(replace(resourceName, '-', ''), 21)}'
var sqlAdmin = 'sqladmin'
var sqlAdminPassword = '${uniqueString(keyVaultName)}Up!P1'
var appUser = 'appUser'
var appUserPassword = '${uniqueString(sqlAdminPassword)}iT$23'


resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: hostingPlanName
  location: location
  sku: {
    tier: 'Standard'
    name: 'S1'
  }
  tags: tags
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: hostingPlan.id
  }

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

resource webApi 'Microsoft.Web/sites@2022-03-01' = {
  name: webApiName
  location: location
  properties: {
    serverFarmId: hostingPlan.id
  }

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
    contentType: 'string'
    value: sqlAdminPassword
  }
}

var connectionString = 'Server=${sqlServer.properties.fullyQualifiedDomainName}; Database=${sqlServer::database.name}; User=${sqlAdmin}'

resource sqlAzureConnectionStringSercret 'Microsoft.KeyVault/vaults/secrets@2022-07-01' = {
  parent: keyVault
  name: 'AZURE-SQL-CONNECTION-STRING'
  properties: {
    value: '${connectionString}; Password=${sqlAdminPassword}'
  }
}

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
    name: 'ContosoUniversity'
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

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: name
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

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: name
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
  }
}

param vaults_kv_use2_devex_demos_name string = 'kv-use2-devex-demos'
param storageAccounts_rgstg912772_name string = 'rgstg912772'
param virtualMachines_vm_vs2022_custom_name string = 'vm-vs2022-custom'
param galleries_cg_org_alpha_useast2_01_name string = 'cg_org_alpha_useast2_01'
param publicIPAddresses_vm_custom_001_ip_name string = 'vm-custom-001-ip'
param devcenters_dc_org_alpha_eastus2_01_name string = 'dc-org-alpha-eastus2-01'
param networkInterfaces_vm_custom_001863_z1_name string = 'vm-custom-001863_z1'
param publicIPAddresses_vm_vs2022_custom_ip_name string = 'vm-vs2022-custom-ip'
param projects_Contoso_University_App_Team_name string = 'Contoso-University-App-Team'
param networkSecurityGroups_vm_custom_001_nsg_name string = 'vm-custom-001-nsg'
param networkInterfaces_vm_vs2022_custom979_z1_name string = 'vm-vs2022-custom979_z1'
param virtualNetworks_vnet_org_alpha_useast2_01_name string = 'vnet-org-alpha-useast2-01'
param networkSecurityGroups_vm_vs2022_custom_nsg_name string = 'vm-vs2022-custom-nsg'
param virtualMachines_vm_custom_vs2022_plusaddons_name string = 'vm-custom-vs2022-plusaddons'
param networkSecurityGroups_vm_org_alpha_team1_nsg_name string = 'vm-org-alpha-team1-nsg'
param schedules_shutdown_computevm_vm_vs2022_custom_name string = 'shutdown-computevm-vm-vs2022-custom'
param publicIPAddresses_vm_custom_vs2022_plusaddons_ip_name string = 'vm-custom-vs2022-plusaddons-ip'
param routeTables_rt_cac_912772_s1_devexdays_alpha_team2_name string = 'rt-cac-912772-s1-devexdays-alpha-team2'
param networkInterfaces_vm_custom_vs2022_plusaddons572_z1_name string = 'vm-custom-vs2022-plusaddons572_z1'
param networkSecurityGroups_vm_alpha_team1_custom_001_nsg_name string = 'vm-alpha-team1-custom-001-nsg'
param networkSecurityGroups_vm_vs2022_win11_custom_001_nsg_name string = 'vm-vs2022-win11-custom-001-nsg'
param networkSecurityGroups_vm_custom_vs2022_plusaddons_nsg_name string = 'vm-custom-vs2022-plusaddons-nsg'
param networkconnections_nc_cac_912772_s1_vnet_alpha_team2_name string = 'nc-cac-912772-s1-vnet-alpha-team2'
param virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name string = 'vnet-cac-912772-s1-devexdays-alpha-team2'
param disks_vm_custom_001_OsDisk_1_140f06ca6ee949e39d680ff465117791_name string = 'vm-custom-001_OsDisk_1_140f06ca6ee949e39d680ff465117791'
param systemTopics_rgstg912772_bcd80280_2a37_4524_a086_720d1a8fd355_name string = 'rgstg912772-bcd80280-2a37-4524-a086-720d1a8fd355'
param userAssignedIdentities_uai_alphateam2_envtype_devdedicated_name string = 'uai-alphateam2-envtype-devdedicated'
param virtualMachines_vm_vs2022_win11_custom_001_externalid string = '/subscriptions/a73ced30-c712-4405-8828-67a833b1e39a/resourceGroups/rg-use2-912772-s1-devexdays-demos-01/providers/Microsoft.Compute/virtualMachines/vm-vs2022-win11-custom-001'
param virtualMachines_vm_custom_001_externalid string = '/subscriptions/a73ced30-c712-4405-8828-67a833b1e39a/resourceGroups/rg-use2-912772-s1-devexdays-demos-01/providers/Microsoft.Compute/virtualMachines/vm-custom-001'
param virtualNetworks_vnet_cac_912772_s1_hub_networking_externalid string = '/subscriptions/a73ced30-c712-4405-8828-67a833b1e39a/resourceGroups/rg-cac-912772-s1-hub-networking-01/providers/Microsoft.Network/virtualNetworks/vnet-cac-912772-s1-hub-networking'

resource galleries_cg_org_alpha_useast2_01_name_resource 'Microsoft.Compute/galleries@2022-03-03' = {
  name: galleries_cg_org_alpha_useast2_01_name
  location: 'eastus2'
  properties: {
    identifier: {}
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_resource 'Microsoft.DevCenter/devcenters@2023-10-01-preview' = {
  name: devcenters_dc_org_alpha_eastus2_01_name
  location: 'eastus2'
  tags: {
    'DevCenter-Name': 'dc-org-alpha-eastus2-01'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    devCenterUri: 'https://bed3f66f-00c5-402e-8f75-44abca53e730-${devcenters_dc_org_alpha_eastus2_01_name}.eastus2.devcenter.azure.com/'
  }
}

resource vaults_kv_use2_devex_demos_name_resource 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaults_kv_use2_devex_demos_name
  location: 'eastus2'
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: 'bed3f66f-00c5-402e-8f75-44abca53e730'
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    enableRbacAuthorization: true
    vaultUri: 'https://${vaults_kv_use2_devex_demos_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource userAssignedIdentities_uai_alphateam2_envtype_devdedicated_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: userAssignedIdentities_uai_alphateam2_envtype_devdedicated_name
  location: 'eastus2'
}

resource networkSecurityGroups_vm_alpha_team1_custom_001_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: networkSecurityGroups_vm_alpha_team1_custom_001_nsg_name
  location: 'eastus2'
  properties: {
    securityRules: [
      {
        name: 'RDP'
        id: networkSecurityGroups_vm_alpha_team1_custom_001_nsg_name_RDP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_vm_custom_001_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: networkSecurityGroups_vm_custom_001_nsg_name
  location: 'eastus2'
  properties: {
    securityRules: [
      {
        name: 'RDP'
        id: networkSecurityGroups_vm_custom_001_nsg_name_RDP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_vm_custom_vs2022_plusaddons_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: networkSecurityGroups_vm_custom_vs2022_plusaddons_nsg_name
  location: 'eastus2'
  properties: {
    securityRules: [
      {
        name: 'RDP'
        id: networkSecurityGroups_vm_custom_vs2022_plusaddons_nsg_name_RDP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_vm_org_alpha_team1_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: networkSecurityGroups_vm_org_alpha_team1_nsg_name
  location: 'eastus2'
  properties: {
    securityRules: [
      {
        name: 'RDP'
        id: networkSecurityGroups_vm_org_alpha_team1_nsg_name_RDP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_vm_vs2022_custom_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: networkSecurityGroups_vm_vs2022_custom_nsg_name
  location: 'eastus2'
  properties: {
    securityRules: [
      {
        name: 'RDP'
        id: networkSecurityGroups_vm_vs2022_custom_nsg_name_RDP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_vm_vs2022_win11_custom_001_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: networkSecurityGroups_vm_vs2022_win11_custom_001_nsg_name
  location: 'eastus2'
  properties: {
    securityRules: [
      {
        name: 'RDP'
        id: networkSecurityGroups_vm_vs2022_win11_custom_001_nsg_name_RDP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '35.142.168.71'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_vm_custom_001_ip_name_resource 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: publicIPAddresses_vm_custom_001_ip_name
  location: 'eastus2'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
  ]
  properties: {
    ipAddress: '172.203.89.116'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_vm_custom_vs2022_plusaddons_ip_name_resource 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: publicIPAddresses_vm_custom_vs2022_plusaddons_ip_name
  location: 'eastus2'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
  ]
  properties: {
    ipAddress: '20.109.90.219'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_vm_vs2022_custom_ip_name_resource 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: publicIPAddresses_vm_vs2022_custom_ip_name
  location: 'eastus2'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
  ]
  properties: {
    ipAddress: '20.186.119.1'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource routeTables_rt_cac_912772_s1_devexdays_alpha_team2_name_resource 'Microsoft.Network/routeTables@2023-05-01' = {
  name: routeTables_rt_cac_912772_s1_devexdays_alpha_team2_name
  location: 'canadacentral'
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'Hub-s2-PrivateDNS-VNet'
        id: routeTables_rt_cac_912772_s1_devexdays_alpha_team2_name_Hub_s2_PrivateDNS_VNet.id
        properties: {
          addressPrefix: '172.17.2.64/26'
          nextHopType: 'VirtualNetworkGateway'
          hasBgpOverride: false
        }
        type: 'Microsoft.Network/routeTables/routes'
      }
    ]
  }
}

resource virtualNetworks_vnet_org_alpha_useast2_01_name_resource 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: virtualNetworks_vnet_org_alpha_useast2_01_name
  location: 'eastus2'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    subnets: [
      {
        name: 'default'
        id: virtualNetworks_vnet_org_alpha_useast2_01_name_default.id
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource storageAccounts_rgstg912772_name_resource 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccounts_rgstg912772_name
  location: 'eastus2'
  tags: {
    'ms-resource-usage': 'azure-cloud-shell'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    networkAcls: {
      resourceAccessRules: [
        {
          tenantId: 'bed3f66f-00c5-402e-8f75-44abca53e730'
          resourceId: '/subscriptions/a73ced30-c712-4405-8828-67a833b1e39a/providers/Microsoft.Security/datascanners/storageDataScanner'
        }
      ]
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource disks_vm_custom_001_OsDisk_1_140f06ca6ee949e39d680ff465117791_name_resource 'Microsoft.Compute/disks@2023-01-02' = {
  name: disks_vm_custom_001_OsDisk_1_140f06ca6ee949e39d680ff465117791_name
  location: 'eastus2'
  sku: {
    name: 'Premium_LRS'
    tier: 'Premium'
  }
  zones: [
    '1'
  ]
  properties: {
    osType: 'Windows'
    hyperVGeneration: 'V2'
    supportedCapabilities: {
      diskControllerTypes: 'SCSI'
      architecture: 'x64'
    }
    creationData: {
      createOption: 'FromImage'
      imageReference: {
        id: galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus_1_0_1.id
      }
      galleryImageReference: {
        id: galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus_1_0_1.id
      }
    }
    diskSizeGB: 127
    diskIOPSReadWrite: 500
    diskMBpsReadWrite: 100
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    securityProfile: {
      securityType: 'TrustedLaunch'
    }
    publicNetworkAccess: 'Enabled'
    diskState: 'Unattached'
    tier: 'P10'
  }
}

resource galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus 'Microsoft.Compute/galleries/images@2022-03-03' = {
  parent: galleries_cg_org_alpha_useast2_01_name_resource
  name: 'vmid-vs2022-win11-customplus'
  location: 'eastus2'
  properties: {
    hyperVGeneration: 'V2'
    architecture: 'x64'
    features: [
      {
        name: 'SecurityType'
        value: 'TrustedLaunch'
      }
      {
        name: 'DiskControllerTypes'
        value: 'SCSI'
      }
    ]
    osType: 'Windows'
    osState: 'Generalized'
    identifier: {
      publisher: 'microsoftvisualstudio'
      offer: 'visualstudioplustools'
      sku: 'vs-2022-ent-general-win11-m365-gen2'
    }
    recommended: {
      vCPUs: {
        min: 1
        max: 16
      }
      memory: {
        min: 1
        max: 32
      }
    }
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_cu_sandbox 'Microsoft.DevCenter/devcenters/catalogs@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'cu-sandbox'
  properties: {
    gitHub: {
      uri: 'https://github.com/embergershared/dev-ex-app.git'
      branch: 'main'
      secretIdentifier: 'https://kv-use2-devex-demos.vault.azure.net/secrets/Github-PAT-to-gopher194/de11c7a6ff4a43cdb1431f238fd016c6'
      path: '/dev-environment/cu-sandbox'
    }
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_Developer_dedicated 'Microsoft.DevCenter/devcenters/environmentTypes@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'Developer-dedicated'
  tags: {
    'DC-environment-type': 'Developer-dedicated'
  }
  properties: {}
}

resource devcenters_dc_org_alpha_eastus2_01_name_Default 'Microsoft.DevCenter/devcenters/galleries@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'Default'
  properties: {
    galleryResourceId: devcenters_dc_org_alpha_eastus2_01_name_Default.id
  }
}

resource networkconnections_nc_cac_912772_s1_vnet_alpha_team2_name_resource 'Microsoft.DevCenter/networkconnections@2023-10-01-preview' = {
  name: networkconnections_nc_cac_912772_s1_vnet_alpha_team2_name
  location: 'canadacentral'
  properties: {
    domainJoinType: 'AzureADJoin'
    subnetId: virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name_devboxes.id
    networkingResourceGroupName: 'NI_${networkconnections_nc_cac_912772_s1_vnet_alpha_team2_name}_canadacentral'
  }
}

resource projects_Contoso_University_App_Team_name_resource 'Microsoft.DevCenter/projects@2023-10-01-preview' = {
  name: projects_Contoso_University_App_Team_name
  location: 'eastus2'
  tags: {
    'DevC-Project': 'Contoso-University-App-Team'
  }
  properties: {
    devCenterId: devcenters_dc_org_alpha_eastus2_01_name_resource.id
    description: 'Contoso University app development team'
    devCenterUri: 'https://bed3f66f-00c5-402e-8f75-44abca53e730-dc-org-alpha-eastus2-01.eastus2.devcenter.azure.com/'
  }
}

resource projects_Contoso_University_App_Team_name_Developer_dedicated 'Microsoft.DevCenter/projects/environmentTypes@2023-10-01-preview' = {
  parent: projects_Contoso_University_App_Team_name_resource
  name: 'Developer-dedicated'
  tags: {
    Team: 'Contoso-University-App-Team'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    deploymentTargetId: '/subscriptions/a73ced30-c712-4405-8828-67a833b1e39a'
    status: 'Enabled'
    creatorRoleAssignment: {
      roles: {
        '8e3af657-a8ff-443c-a75c-2fe8c4bcb635': {}
      }
    }
  }
}

resource projects_Contoso_University_App_Team_name_Blank_Large 'Microsoft.DevCenter/projects/pools@2023-10-01-preview' = {
  parent: projects_Contoso_University_App_Team_name_resource
  name: 'Blank-Large'
  location: 'eastus2'
  properties: {
    devBoxDefinitionName: 'dvbd-vs2022-devbox-team1-large'
    networkConnectionName: 'nc-cac-912772-s1-vnet-alpha-team2'
    licenseType: 'Windows_Client'
    localAdministrator: 'Enabled'
    singleSignOnStatus: 'Disabled'
    virtualNetworkType: 'Unmanaged'
  }
}

resource projects_Contoso_University_App_Team_name_Blank_Medium 'Microsoft.DevCenter/projects/pools@2023-10-01-preview' = {
  parent: projects_Contoso_University_App_Team_name_resource
  name: 'Blank-Medium'
  location: 'eastus2'
  properties: {
    devBoxDefinitionName: 'dvbd-vs2022-devbox-team1-medium'
    networkConnectionName: 'nc-cac-912772-s1-vnet-alpha-team2'
    licenseType: 'Windows_Client'
    localAdministrator: 'Enabled'
    singleSignOnStatus: 'Disabled'
    virtualNetworkType: 'Unmanaged'
  }
}

resource schedules_shutdown_computevm_vm_vs2022_custom_name_resource 'microsoft.devtestlab/schedules@2018-09-15' = {
  name: schedules_shutdown_computevm_vm_vs2022_custom_name
  location: 'eastus2'
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: '1900'
    }
    timeZoneId: 'Eastern Standard Time'
    notificationSettings: {
      status: 'Disabled'
      timeInMinutes: 30
      notificationLocale: 'en'
    }
    targetResourceId: virtualMachines_vm_vs2022_custom_name_resource.id
  }
}

resource systemTopics_rgstg912772_bcd80280_2a37_4524_a086_720d1a8fd355_name_resource 'Microsoft.EventGrid/systemTopics@2023-06-01-preview' = {
  name: systemTopics_rgstg912772_bcd80280_2a37_4524_a086_720d1a8fd355_name
  location: 'eastus2'
  properties: {
    source: storageAccounts_rgstg912772_name_resource.id
    topicType: 'microsoft.storage.storageaccounts'
  }
}

resource systemTopics_rgstg912772_bcd80280_2a37_4524_a086_720d1a8fd355_name_StorageAntimalwareSubscription 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2023-06-01-preview' = {
  parent: systemTopics_rgstg912772_bcd80280_2a37_4524_a086_720d1a8fd355_name_resource
  name: 'StorageAntimalwareSubscription'
  properties: {
    destination: {
      properties: {
        maxEventsPerBatch: 1
        preferredBatchSizeInKilobytes: 64
        azureActiveDirectoryTenantId: '33e01921-4d64-4f8c-a055-5bdaffd5e33d'
        azureActiveDirectoryApplicationIdOrUri: 'f1f8da5f-609a-401d-85b2-d498116b7265'
      }
      endpointType: 'WebHook'
    }
    filter: {
      includedEventTypes: [
        'Microsoft.Storage.BlobCreated'
      ]
      advancedFilters: [
        {
          values: [
            'BlockBlob'
          ]
          operatorType: 'StringContains'
          key: 'data.blobType'
        }
      ]
    }
    eventDeliverySchema: 'EventGridSchema'
    retryPolicy: {
      maxDeliveryAttempts: 30
      eventTimeToLiveInMinutes: 1440
    }
  }
}

resource vaults_kv_use2_devex_demos_name_Github_PAT_to_gopher194 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: vaults_kv_use2_devex_demos_name_resource
  name: 'Github-PAT-to-gopher194'
  location: 'eastus2'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource networkSecurityGroups_vm_alpha_team1_custom_001_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2023-05-01' = {
  name: '${networkSecurityGroups_vm_alpha_team1_custom_001_nsg_name}/RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_alpha_team1_custom_001_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_custom_001_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2023-05-01' = {
  name: '${networkSecurityGroups_vm_custom_001_nsg_name}/RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_custom_001_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_custom_vs2022_plusaddons_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2023-05-01' = {
  name: '${networkSecurityGroups_vm_custom_vs2022_plusaddons_nsg_name}/RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_custom_vs2022_plusaddons_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_org_alpha_team1_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2023-05-01' = {
  name: '${networkSecurityGroups_vm_org_alpha_team1_nsg_name}/RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_org_alpha_team1_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_vs2022_custom_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2023-05-01' = {
  name: '${networkSecurityGroups_vm_vs2022_custom_nsg_name}/RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_vs2022_custom_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_vs2022_win11_custom_001_nsg_name_RDP 'Microsoft.Network/networkSecurityGroups/securityRules@2023-05-01' = {
  name: '${networkSecurityGroups_vm_vs2022_win11_custom_001_nsg_name}/RDP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '35.142.168.71'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 300
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_vs2022_win11_custom_001_nsg_name_resource
  ]
}

resource routeTables_rt_cac_912772_s1_devexdays_alpha_team2_name_Hub_s2_PrivateDNS_VNet 'Microsoft.Network/routeTables/routes@2023-05-01' = {
  name: '${routeTables_rt_cac_912772_s1_devexdays_alpha_team2_name}/Hub-s2-PrivateDNS-VNet'
  properties: {
    addressPrefix: '172.17.2.64/26'
    nextHopType: 'VirtualNetworkGateway'
    hasBgpOverride: false
  }
  dependsOn: [
    routeTables_rt_cac_912772_s1_devexdays_alpha_team2_name_resource
  ]
}

resource virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name_resource 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name
  location: 'canadacentral'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '172.17.80.0/24'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    dhcpOptions: {
      dnsServers: [
        '172.17.2.69'
        '172.17.2.70'
      ]
    }
    subnets: [
      {
        name: 'devboxes'
        id: virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name_devboxes.id
        properties: {
          addressPrefix: '172.17.80.0/24'
          routeTable: {
            id: routeTables_rt_cac_912772_s1_devexdays_alpha_team2_name_resource.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: true
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'peering-to-hub-vnet'
        id: virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name_peering_to_hub_vnet.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_cac_912772_s1_hub_networking_externalid
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: true
          doNotVerifyRemoteGateways: false
          remoteAddressSpace: {
            addressPrefixes: [
              '172.17.1.0/24'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '172.17.1.0/24'
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_org_alpha_useast2_01_name_default 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
  name: '${virtualNetworks_vnet_org_alpha_useast2_01_name}/default'
  properties: {
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_org_alpha_useast2_01_name_resource
  ]
}

resource virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name_peering_to_hub_vnet 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-05-01' = {
  name: '${virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name}/peering-to-hub-vnet'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_cac_912772_s1_hub_networking_externalid
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: true
    doNotVerifyRemoteGateways: false
    remoteAddressSpace: {
      addressPrefixes: [
        '172.17.1.0/24'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '172.17.1.0/24'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name_resource
  ]
}

resource storageAccounts_rgstg912772_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccounts_rgstg912772_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgstg912772_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-01-01' = {
  parent: storageAccounts_rgstg912772_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_rgstg912772_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-01-01' = {
  parent: storageAccounts_rgstg912772_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgstg912772_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-01-01' = {
  parent: storageAccounts_rgstg912772_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus_0_0_1 'Microsoft.Compute/galleries/images/versions@2022-03-03' = {
  parent: galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus
  name: '0.0.1'
  location: 'eastus2'
  properties: {
    publishingProfile: {
      targetRegions: [
        {
          name: 'East US 2'
          regionalReplicaCount: 1
          storageAccountType: 'Standard_ZRS'
        }
      ]
      replicaCount: 1
      excludeFromLatest: false
      storageAccountType: 'Standard_LRS'
      replicationMode: 'Full'
    }
    storageProfile: {
      source: {
        id: virtualMachines_vm_vs2022_win11_custom_001_externalid
      }
      osDiskImage: {
        hostCaching: 'ReadWrite'
        source: {}
      }
    }
    safetyProfile: {
      allowDeletionOfReplicatedLocations: true
    }
  }
  dependsOn: [

    galleries_cg_org_alpha_useast2_01_name_resource
  ]
}

resource galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus_1_1_1 'Microsoft.Compute/galleries/images/versions@2022-03-03' = {
  parent: galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus
  name: '1.1.1'
  location: 'eastus2'
  properties: {
    publishingProfile: {
      targetRegions: [
        {
          name: 'East US 2'
          regionalReplicaCount: 1
          storageAccountType: 'Standard_ZRS'
        }
        {
          name: 'Canada Central'
          regionalReplicaCount: 1
          storageAccountType: 'Standard_LRS'
        }
      ]
      replicaCount: 1
      excludeFromLatest: false
      storageAccountType: 'Standard_LRS'
      replicationMode: 'Full'
    }
    storageProfile: {
      source: {
        id: virtualMachines_vm_custom_001_externalid
      }
      osDiskImage: {
        hostCaching: 'ReadWrite'
        source: {}
      }
    }
    safetyProfile: {
      allowDeletionOfReplicatedLocations: true
    }
  }
  dependsOn: [

    galleries_cg_org_alpha_useast2_01_name_resource
  ]
}

resource virtualMachines_vm_custom_vs2022_plusaddons_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_vm_custom_vs2022_plusaddons_name
  location: 'eastus2'
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D8ads_v5'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        id: galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus_1_1_1.id
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_custom_vs2022_plusaddons_name}_OsDisk_1_ba926041deea4bbfa3082ec0f09d63b4'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_vm_custom_vs2022_plusaddons_name}_OsDisk_1_ba926041deea4bbfa3082ec0f09d63b4')
        }
        deleteOption: 'Detach'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'vm-custom-vs202'
      adminUsername: 'gaciampa'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_custom_vs2022_plusaddons572_z1_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    licenseType: 'Windows_Client'
  }
}

resource virtualMachines_vm_vs2022_custom_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_vm_vs2022_custom_name
  location: 'eastus2'
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D8ads_v5'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        id: galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus_0_0_1.id
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_vs2022_custom_name}_OsDisk_1_948941243c15434d8a497d51c63bee1b'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_vm_vs2022_custom_name}_OsDisk_1_948941243c15434d8a497d51c63bee1b')
        }
        deleteOption: 'Detach'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'vm-vs2022-custo'
      adminUsername: 'gaciampa'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_vs2022_custom979_z1_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    licenseType: 'Windows_Client'
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_nc_cac_912772_s1_vnet_alpha_team2 'Microsoft.DevCenter/devcenters/attachednetworks@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'nc-cac-912772-s1-vnet-alpha-team2'
  properties: {
    networkConnectionId: networkconnections_nc_cac_912772_s1_vnet_alpha_team2_name_resource.id
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_dvbd_vs2022_devbox_team1_custom_8vcpu 'Microsoft.DevCenter/devcenters/devboxdefinitions@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'dvbd-vs2022-devbox-team1-custom-8vcpu'
  location: 'eastus2'
  properties: {
    imageReference: {
      id: '${devcenters_dc_org_alpha_eastus2_01_name_cg_org_alpha_useast2_01.id}/images/vmid-vs2022-win11-customplus'
    }
    sku: {
      name: 'general_i_8c32gb256ssd_v2'
    }
    hibernateSupport: 'Disabled'
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_dvbd_vs2022_devbox_team1_custom_docker_datastudio 'Microsoft.DevCenter/devcenters/devboxdefinitions@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'dvbd-vs2022-devbox-team1-custom-docker-datastudio'
  location: 'eastus2'
  properties: {
    imageReference: {
      id: '${devcenters_dc_org_alpha_eastus2_01_name_cg_org_alpha_useast2_01.id}/images/vmid-vs2022-win11-customplus/versions/1.0.1'
    }
    sku: {
      name: 'general_i_8c32gb256ssd_v2'
    }
    hibernateSupport: 'Disabled'
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_dvbd_vs2022_devbox_team1_large 'Microsoft.DevCenter/devcenters/devboxdefinitions@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'dvbd-vs2022-devbox-team1-large'
  location: 'eastus2'
  properties: {
    imageReference: {
      id: '${devcenters_dc_org_alpha_eastus2_01_name_Default.id}/images/microsoftvisualstudio_visualstudioplustools_vs-2022-ent-general-win11-m365-gen2'
    }
    sku: {
      name: 'general_i_32c128gb1024ssd_v2'
    }
    hibernateSupport: 'Disabled'
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_dvbd_vs2022_devbox_team1_medium 'Microsoft.DevCenter/devcenters/devboxdefinitions@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'dvbd-vs2022-devbox-team1-medium'
  location: 'eastus2'
  properties: {
    imageReference: {
      id: '${devcenters_dc_org_alpha_eastus2_01_name_Default.id}/images/microsoftvisualstudio_visualstudioplustools_vs-2022-ent-general-win11-m365-gen2'
    }
    sku: {
      name: 'general_i_16c64gb256ssd_v2'
    }
    hibernateSupport: 'Disabled'
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_dvbd_vs2022_devbox_team1_small 'Microsoft.DevCenter/devcenters/devboxdefinitions@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'dvbd-vs2022-devbox-team1-small'
  location: 'eastus2'
  properties: {
    imageReference: {
      id: '${devcenters_dc_org_alpha_eastus2_01_name_Default.id}/images/microsoftvisualstudio_visualstudioplustools_vs-2022-ent-general-win11-m365-gen2'
    }
    sku: {
      name: 'general_i_8c32gb256ssd_v2'
    }
    hibernateSupport: 'Disabled'
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_dvbd_vs2022_devbox_team2_custom_alladdons 'Microsoft.DevCenter/devcenters/devboxdefinitions@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'dvbd-vs2022-devbox-team2-custom-alladdons'
  location: 'eastus2'
  properties: {
    imageReference: {
      id: '${devcenters_dc_org_alpha_eastus2_01_name_cg_org_alpha_useast2_01.id}/images/vmid-vs2022-win11-customplus'
    }
    sku: {
      name: 'general_i_16c64gb256ssd_v2'
    }
    hibernateSupport: 'Disabled'
  }
}

resource devcenters_dc_org_alpha_eastus2_01_name_cg_org_alpha_useast2_01 'Microsoft.DevCenter/devcenters/galleries@2023-10-01-preview' = {
  parent: devcenters_dc_org_alpha_eastus2_01_name_resource
  name: 'cg_org_alpha_useast2_01'
  properties: {
    galleryResourceId: galleries_cg_org_alpha_useast2_01_name_resource.id
  }
}

resource projects_Contoso_University_App_Team_name_Blank_Large_default 'Microsoft.DevCenter/projects/pools/schedules@2023-10-01-preview' = {
  parent: projects_Contoso_University_App_Team_name_Blank_Large
  name: 'default'
  properties: {
    type: 'StopDevBox'
    frequency: 'Daily'
    time: '21:30'
    timeZone: 'America/New_York'
    state: 'Enabled'
  }
  dependsOn: [

    projects_Contoso_University_App_Team_name_resource
  ]
}

resource projects_Contoso_University_App_Team_name_Blank_Medium_default 'Microsoft.DevCenter/projects/pools/schedules@2023-10-01-preview' = {
  parent: projects_Contoso_University_App_Team_name_Blank_Medium
  name: 'default'
  properties: {
    type: 'StopDevBox'
    frequency: 'Daily'
    time: '20:30'
    timeZone: 'America/New_York'
    state: 'Enabled'
  }
  dependsOn: [

    projects_Contoso_University_App_Team_name_resource
  ]
}

resource virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name_devboxes 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
  name: '${virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name}/devboxes'
  properties: {
    addressPrefix: '172.17.80.0/24'
    routeTable: {
      id: routeTables_rt_cac_912772_s1_devexdays_alpha_team2_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: true
  }
  dependsOn: [
    virtualNetworks_vnet_cac_912772_s1_devexdays_alpha_team2_name_resource

  ]
}

resource storageAccounts_rgstg912772_name_default_storageAccounts_rgstg912772_name_share 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-01-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgstg912772_name_default
  name: '${storageAccounts_rgstg912772_name}share'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 6
    enabledProtocols: 'SMB'
  }
  dependsOn: [

    storageAccounts_rgstg912772_name_resource
  ]
}

resource galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus_1_0_1 'Microsoft.Compute/galleries/images/versions@2022-03-03' = {
  parent: galleries_cg_org_alpha_useast2_01_name_vmid_vs2022_win11_customplus
  name: '1.0.1'
  location: 'eastus2'
  properties: {
    publishingProfile: {
      targetRegions: [
        {
          name: 'East US 2'
          regionalReplicaCount: 1
          storageAccountType: 'Premium_LRS'
        }
      ]
      replicaCount: 1
      excludeFromLatest: false
      storageAccountType: 'Standard_LRS'
      replicationMode: 'Full'
    }
    storageProfile: {
      source: {
        id: virtualMachines_vm_vs2022_custom_name_resource.id
      }
      osDiskImage: {
        hostCaching: 'ReadWrite'
        source: {}
      }
    }
    safetyProfile: {
      allowDeletionOfReplicatedLocations: true
    }
  }
  dependsOn: [

    galleries_cg_org_alpha_useast2_01_name_resource

  ]
}

resource networkInterfaces_vm_custom_001863_z1_name_resource 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: networkInterfaces_vm_custom_001863_z1_name
  location: 'eastus2'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_custom_001863_z1_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"0d75e6f4-def2-4d0e-98e7-82872b6794d2"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.8'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vm_custom_001_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_vnet_org_alpha_useast2_01_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_vm_custom_001_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_vm_custom_vs2022_plusaddons572_z1_name_resource 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: networkInterfaces_vm_custom_vs2022_plusaddons572_z1_name
  location: 'eastus2'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_custom_vs2022_plusaddons572_z1_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"06c7c49a-9145-4adc-982f-3ec9621b3033"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vm_custom_vs2022_plusaddons_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_vnet_org_alpha_useast2_01_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_vm_custom_vs2022_plusaddons_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_vm_vs2022_custom979_z1_name_resource 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: networkInterfaces_vm_vs2022_custom979_z1_name
  location: 'eastus2'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_vs2022_custom979_z1_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"de7a9520-930d-4a27-9881-876f8d982928"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.0.0.9'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vm_vs2022_custom_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_vnet_org_alpha_useast2_01_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_vm_vs2022_custom_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
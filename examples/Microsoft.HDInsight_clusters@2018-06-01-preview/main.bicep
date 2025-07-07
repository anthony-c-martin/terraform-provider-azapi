param location string = 'westeurope'
param resource_name string = 'acctest0001'

resource cluster 'Microsoft.HDInsight/clusters@2018-06-01-preview' = {
  location: location
  name: resource_name
  properties: {
    clusterDefinition: {
      componentVersion: {
        Spark: '2.4'
      }
      configurations: {
        gateway: {
          'restAuthCredential.isEnabled': true
          'restAuthCredential.password': 'TerrAform123!'
          'restAuthCredential.username': 'acctestusrgw'
        }
      }
      kind: 'Spark'
    }
    clusterVersion: '4.0.3000.1'
    computeProfile: {
      roles: [
        {
          hardwareProfile: {
            vmSize: 'standard_a4_v2'
          }
          name: 'headnode'
          osProfile: {
            linuxOperatingSystemProfile: {
              password: 'AccTestvdSC4daf986!'
              username: 'acctestusrvm'
            }
          }
          targetInstanceCount: 2
        }
        {
          hardwareProfile: {
            vmSize: 'standard_a4_v2'
          }
          name: 'workernode'
          osProfile: {
            linuxOperatingSystemProfile: {
              password: 'AccTestvdSC4daf986!'
              username: 'acctestusrvm'
            }
          }
          targetInstanceCount: 3
        }
        {
          hardwareProfile: {
            vmSize: 'standard_a2_v2'
          }
          name: 'zookeepernode'
          osProfile: {
            linuxOperatingSystemProfile: {
              password: 'AccTestvdSC4daf986!'
              username: 'acctestusrvm'
            }
          }
          targetInstanceCount: 3
        }
      ]
    }
    encryptionInTransitProperties: {
      isEncryptionInTransitEnabled: false
    }
    minSupportedTlsVersion: '1.2'
    osType: 'Linux'
    storageProfile: {
      storageaccounts: [
        {
          container: container.name
          isDefault: true
          key: data.azapi_resource_action.listKeys.output.keys[0].value
          name: '${storageAccount.name}.blob.core.windows.net'
          resourceId: storageAccount.id
        }
      ]
    }
    tier: 'standard'
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: resource_name
  properties: {
    metadata: {
      key: 'value'
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  location: location
  name: resource_name
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
  }
}


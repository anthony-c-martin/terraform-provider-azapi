param location string = 'westeurope'
param resource_name string = 'acctest0001'

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2014-04-01' = {
  parent: server
  name: resource_name
  properties: {
    endIpAddress: '255.255.255.255'
    startIpAddress: '0.0.0.0'
  }
}

resource server 'Microsoft.Sql/servers@2015-05-01-preview' = {
  location: location
  name: resource_name
  properties: {
    administratorLogin: 'mradministrator'
    administratorLoginPassword: 'thisIsDog11'
    version: '12.0'
  }
}


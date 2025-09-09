targetScope = 'subscription'
param location string = 'eastus'
param name string = 'rg-bicep-dev'

resource azbiceprg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
  tags: {
    environment: 'dev'
  }
  properties: {}
}


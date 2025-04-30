targetScope = 'subscription'

resource azbiceprg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep-test'
  location: 'eastus'
  tags: {
    environment: 'dev'
  }
  properties: {}
}

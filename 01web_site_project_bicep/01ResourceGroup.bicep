targetScope = 'subscription'

resource azbiceprg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep-test'
  location: 'eastus'
  tags: {
    environment: 'dev'
  }
  properties: {}
}

resource azbiceprgdev 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep-dev-test'
  location: 'eastus'
  tags: {
    environment: 'dev'
  }
  properties: {}
}

resource azbiceprgstg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep-stg-test'
  location: 'eastus'
  tags: {
    environment: 'stg'
  }
  properties: {}
}

resource azbiceprgprd 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep-prd-test'
  location: 'eastus'
  tags: {
    environment: 'prd'
  }
  properties: {}
}

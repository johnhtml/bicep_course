param location string
param appServicePlanName string
param skuName string
param skuTier string
param skuCapacity int
param appInsightsInstrumentationKey string
param appInsightsConnectionString string
param functionAppName string
param environment string
param storageAccountName string
param storageAccountId string
param tableName string


var storageAccountConnectionString = 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listKeys(storageAccountId, '2022-09-01').keys[0].value};EndpointSuffix=core.windows.net'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    tier: skuTier
    capacity: skuCapacity
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.12'
      appSettings: [
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsightsConnectionString
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsightsInstrumentationKey
        }
        {
          name: 'AzureWebJobsStorage'
          value: storageAccountConnectionString
        }
        {
          name: 'STORAGE_ACCOUNT_NAME'
          value: storageAccountName
        }
        {
          name: 'AZURE_FUNCTIONS_ENVIRONMENT'
          value: environment
        }
        {
          name: 'TABLE_NAME'
          value: tableName
        }
      ]
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}

output functionAppPrincipalId string = functionApp.identity.principalId
output functionAppName string = functionApp.name

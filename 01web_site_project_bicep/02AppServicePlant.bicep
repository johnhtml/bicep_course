param location string
param appServicePlanName string
param skuName string
param skuTier string
param skuCapacity int

param webAppName string
param appInsightsInstrumentationKey string
param appInsightsConnectionString string


resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    tier: skuTier
    capacity: skuCapacity
  }
}

/*
resource appServicePlan2 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'app-service-plan-linux-bicep-test'
  kind : 'linux'
  properties: {
    reserved: true
  }
  location: location
  sku: {
    name: 'f1'
    tier: 'Free'
    capacity: skuCapacity
  }
}
*/




resource webApplication 'Microsoft.Web/sites@2020-12-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
  }
  identity: {
    type: 'SystemAssigned'
  }
}

resource webApplicationSettings 'Microsoft.Web/sites/config@2020-12-01' = {
  parent: webApplication
  name: 'web'
  properties: {
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: appInsightsInstrumentationKey
      }
      {
        name: 'APPINSIGHTS_PROFILERFEATURE_VERSION'
        value: 'disabled'
      }
      {
        name: 'APPINSIGHTS_SAMPLING_PERCENTAGE'
        value: '20'
      }
      {
        name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
        value: appInsightsConnectionString
      }
      {
        name: 'AzureWebJobsDashboard'
        value: appInsightsConnectionString
      }
      {
        name: 'AzureWebJobsInstrumentationKey'
        value: appInsightsInstrumentationKey
      }
      {
        name: 'WEBSITE_APPLICATIONINSIGHTS_LIVEMETRICS_ENABLED'
        value: 'true'
      }
    ]
  }
}

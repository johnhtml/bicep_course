resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'app-service-plan-bicep-test'
  location: resourceGroup().location
  sku: {
    name: 'F1'
    tier: 'Free'
    capacity: 1
  }
}

/*
resource appServicePlan2 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'app-service-plan-linux-bicep-test'
  kind : 'linux'
  properties: {
    reserved: true
  }
  location: 'eastus'
  sku: {
    name: 'f1'
    tier: 'Free'
    capacity: 1
  }
}
*/

resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: 'app-insights-bicep-test'
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 60
  }
}



resource webApplication 'Microsoft.Web/sites@2020-12-01' = {
  name: 'webapp-bicep-test'
  location: resourceGroup().location
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
        value: appInsightsComponents.properties.InstrumentationKey
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
        value: appInsightsComponents.properties.ConnectionString
      }
      {
        name: 'AzureWebJobsDashboard'
        value: appInsightsComponents.properties.ConnectionString
      }
      {
        name: 'AzureWebJobsInstrumentationKey'
        value: appInsightsComponents.properties.InstrumentationKey
      }
      {
        name: 'WEBSITE_APPLICATIONINSIGHTS_LIVEMETRICS_ENABLED'
        value: 'true'
      }
    ]
  }
}

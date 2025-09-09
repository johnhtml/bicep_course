param environment string
param location string
param locationCosmosDB string
param appServicePlanName string
@description(''''
Please select the SKU name for the App Service Plan.
- F1: Free
- B1: Basic
- B2: Basic
- B3: Basic
- S1: Standard
- S2: Standard
''')
@allowed(['F1', 'B1', 'B2', 'B3', 'S1', 'S2'])
param skuName string = (environment != 'prd') ? 'S1' : 'S2'
param skuTier string
@minValue(1)
@maxValue(3)
param skuCapacity int  = (environment != 'prd') ? 1 : 3
param appInsightsName string
param appInsightsRetentionInDays int
param functionAppName string
param storageAccountName string
param cosmosDbAccountName string

module StorageAccount '03StorageAccount.bicep' = {
  name: 'StorageAccount'
  params:{
    storageAccountName: storageAccountName
    location: location
  }
}

module AppServicePlan '02AppServicePlan.bicep' = {
  name: 'AppServicePlan'
  params: {
    location: location
    appServicePlanName: appServicePlanName
    skuName: skuName
    skuTier: skuTier
    skuCapacity: skuCapacity
    appInsightsInstrumentationKey: AppInsights.outputs.appInsightsInstrumentationKey
    appInsightsConnectionString: AppInsights.outputs.appInsightsConnectionString
    functionAppName: functionAppName
    environment: environment
    storageAccountName: storageAccountName
    storageAccountId: StorageAccount.outputs.storageAccountId
  }
}

module AppInsights '04AppInsights.bicep' = {
  name: 'AppInsights'
  params:{
    appInsightsName: appInsightsName
    appInsightsRetentionInDays: appInsightsRetentionInDays
    location: location
  }
}

module CosmosDB '05CosmosDB.bicep' = {
  name: 'CosmosDB'
  params:{
    cosmosDbAccountName: cosmosDbAccountName
    location: locationCosmosDB
    functionAppPrincipalId: AppServicePlan.outputs.functionAppPrincipalId
  }
}

output functionAppName string = AppServicePlan.outputs.functionAppName
output storageAccountName string = StorageAccount.outputs.storageAccountName

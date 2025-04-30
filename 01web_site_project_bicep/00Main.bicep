param location string = resourceGroup().location
param appServicePlanName string = 'app-service-plan-bicep-test'
param skuName string = 'F1'
param skuTier string = 'Free'
param skuCapacity int = 1
param appInsightsName string = 'app-insights-bicep-test'
param appInsightsRetentionInDays int = 60
param webAppName string = 'webapp-bicep-test'

param pSqlServerName string = 'sql-server-bicep-test-998987987'
param pSqlDBName string = 'sql-server-bicep-test-998987987'


module AppServicePlan '02AppServicePlant.bicep' = {
  name: 'AppServicePlan'
  params: {
    location: location
    appServicePlanName: appServicePlanName
    skuName: skuName
    skuTier: skuTier
    skuCapacity: skuCapacity
    appInsightsInstrumentationKey: AppInsights.outputs.appInsightsInstrumentationKey
    appInsightsConnectionString: AppInsights.outputs.appInsightsConnectionString
    webAppName: webAppName
  }
}

module SQLdatabase '03SQLdatabase.bicep' = {
  name: 'SQLdatabase'
  params:{
    pSqlServerName: pSqlServerName
    pSqlDBName: pSqlDBName
    location: location
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

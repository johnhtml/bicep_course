param location string
param appServicePlanName string
param skuName string
param skuTier string
param skuCapacity int
param appInsightsName string
param appInsightsRetentionInDays int
param webAppName string

param pSqlServerName string
param pSqlDBName string


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

param environment string
param location string
param appServicePlanName string
@description(''''
Please select the SKU name for the App Service Plan.
- F1: Free
- B1: Basic
- B2: Basic
- B3: Basic
- S1: Standard
''')
@allowed(['F1', 'B1', 'B2', 'B3', 'S1'])
param skuName string = (environment != 'prd') ? 'B1' : 'S1'
param skuTier string
@minValue(1)
@maxValue(3)
param skuCapacity int  = (environment != 'prd') ? 3 : 1
param appInsightsName string
param appInsightsRetentionInDays int
param webAppName string

param pSqlServerName string
param pSqlDBName string

param administratorLogin string
//@secure()
//param administratorLoginPassword string
param keyvaultName string


resource KeyVault 'Microsoft.KeyVault/vaults@2022-07-01' existing = {
  name: keyvaultName
}


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
    administratorLogin: administratorLogin
    administratorLoginPassword: KeyVault.getSecret('administratorLoginPassword')
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

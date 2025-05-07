param appInsightsName string
param appInsightsRetentionInDays int
param location string


resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: appInsightsRetentionInDays
  }
}

output appInsightsInstrumentationKey string = appInsightsComponents.properties.InstrumentationKey
output appInsightsConnectionString string = appInsightsComponents.properties.ConnectionString

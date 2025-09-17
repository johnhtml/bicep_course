param location string
param appConfigName string
param functionAppPrincipalId string

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2025-02-01-preview' = {
  name: appConfigName
  location: location
  sku: {
    name: 'Standard'
  }
}

resource appConfigDataReaderRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(appConfig.id, functionAppPrincipalId, '516239f1-63e1-4d78-a4de-a74fb236a071') // App Configuration Data Reader
  scope: appConfig
  properties: {
    principalId: functionAppPrincipalId
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '516239f1-63e1-4d78-a4de-a74fb236a071')
    principalType: 'ServicePrincipal'
  }
}

output appConfigEndpoint string = appConfig.properties.endpoint

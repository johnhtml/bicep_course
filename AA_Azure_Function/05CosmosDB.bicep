param cosmosDbAccountName string
param location string
param functionAppPrincipalId string
@allowed([
  '00000000-0000-0000-0000-000000000001' // Built-in Data Reader
  '00000000-0000-0000-0000-000000000002' // Built-in Data Contributor
])
param cosmosDbRoleDefinitionId string = '00000000-0000-0000-0000-000000000002'

resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2023-09-15' = {
  name: cosmosDbAccountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    enableFreeTier: true
  }
}

resource sqlRoleAssignment 'Microsoft.DocumentDB/databaseAccounts/sqlRoleAssignments@2023-09-15' = {
  name: guid(cosmosDbRoleDefinitionId, functionAppPrincipalId, cosmosDbAccount.id)
  parent: cosmosDbAccount
  properties: {
    principalId: functionAppPrincipalId
    roleDefinitionId: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.DocumentDB/databaseAccounts/${cosmosDbAccount.name}/sqlRoleDefinitions/${cosmosDbRoleDefinitionId}'
    scope: cosmosDbAccount.id
  }
}

output cosmosDbAccountEndpoint string = cosmosDbAccount.properties.documentEndpoint
output cosmosDbAccountId string = cosmosDbAccount.id

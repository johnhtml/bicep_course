param storageAccountName string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
  }
}


// resource storageBlobContributorRole 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
//   name: guid(storageAccount.id, functionAppPrincipalId, 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
//   scope: storageAccount
//   properties: {
//     roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
//     principalId: functionAppPrincipalId
//     principalType: 'ServicePrincipal'
//   }
// }

// resource storageTableContributorRole 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
//   name: guid(storageAccount.id, functionAppPrincipalId, '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1')
//   scope: storageAccount
//   properties: {
//     roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1')
//     principalId: functionAppPrincipalId
//     principalType: 'ServicePrincipal'
//   }
// }

// resource storageQueueContributorRole 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
//   name: guid(storageAccount.id, functionAppPrincipalId, '974c5e8b-45b9-4653-ba55-5f855dd0fb88')
//   scope: storageAccount
//   properties: {
//     roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '974c5e8b-45b9-4653-ba55-5f855dd0fb88')
//     principalId: functionAppPrincipalId
//     principalType: 'ServicePrincipal'
//   }
// }


output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name

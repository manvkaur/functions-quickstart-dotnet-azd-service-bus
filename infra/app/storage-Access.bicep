param storageAccountName string
param principalIds array
param principalTypes array
param roleId string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: storageAccountName
}

// Allow access from API to storage account using a managed identity and least priv Storage roles
resource storageRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = [for (principalId, i) in principalIds: {
  name: guid(storageAccount.id, principalId, roleId)
  scope: storageAccount
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleId)
    principalId: principalId
    principalType: principalTypes[i]
  }
}]

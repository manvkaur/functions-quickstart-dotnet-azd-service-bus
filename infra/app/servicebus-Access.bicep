param serviceBusNamespaceName string
param roleDefinitionId string
param principalIds array
param principalTypes array

resource ServiceBusResource 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' existing = {
  name: serviceBusNamespaceName
}

resource ServiceBusRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = [for (principalId, i) in principalIds: {
  name: guid(ServiceBusResource.id, principalId, roleDefinitionId)
  scope: ServiceBusResource
  properties: {
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
    principalId: principalId
    principalType: principalTypes[i]
  }
}]

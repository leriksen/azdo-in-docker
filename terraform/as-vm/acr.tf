resource "azurerm_container_registry" "acr" {
  name                = "azdocr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_role_assignment" "push" {
  principal_id = azurerm_user_assigned_identity.azdo.principal_id
  scope        = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"
}

resource "azurerm_role_assignment" "pull" {
  principal_id = azurerm_user_assigned_identity.azdo.principal_id
  scope        = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
}
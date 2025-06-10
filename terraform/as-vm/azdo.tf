resource "azuredevops_agent_pool" "azdo-pool" {
  name           = "azdo-in-docker"
  auto_provision = true
  auto_update    = false
}

data azuredevops_project "azdo" {
  name = "azdo-in-docker"
}

resource "azurerm_user_assigned_identity" "azdo" {
  location            = azurerm_resource_group.rg.location
  name                = "azdo-identity"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azuredevops_serviceendpoint_azurerm" "sc_azurerm" {
  project_id                             = data.azuredevops_project.azdo.id
  service_endpoint_name                  = "sc_azdo"
  description                            = "Managed by Terraform"
  service_endpoint_authentication_scheme = "WorkloadIdentityFederation"
  credentials {
    serviceprincipalid = azurerm_user_assigned_identity.azdo.client_id
  }
  azurerm_spn_tenantid      = data.azurerm_client_config.current.tenant_id
  azurerm_subscription_id   = data.azurerm_subscription.current.subscription_id
  azurerm_subscription_name = data.azurerm_subscription.current.display_name
}

resource "azurerm_federated_identity_credential" "azdo_fed_cred" {
  name                = "azdo-federated-credential"
  resource_group_name = azurerm_resource_group.rg.name
  parent_id           = azurerm_user_assigned_identity.azdo.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azuredevops_serviceendpoint_azurerm.sc_azurerm.workload_identity_federation_issuer
  subject             = azuredevops_serviceendpoint_azurerm.sc_azurerm.workload_identity_federation_subject
}
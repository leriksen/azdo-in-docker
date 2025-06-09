resource "azuredevops_agent_pool" "azdo-pool" {
  name           = "azdo-in-docker"
  auto_provision = true
  auto_update    = false
}
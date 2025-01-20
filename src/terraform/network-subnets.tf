locals {
  default_address_space = cidrsubnet(var.base_address_space, 2, 1)
}
resource "azurerm_subnet" "default" {
  name                 = "snet-default"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.default_address_space]
}
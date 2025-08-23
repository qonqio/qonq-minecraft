
resource "azurerm_network_security_group" "main" {
  name                = "nsg-default"
  resource_group_name = var.resource_group_name
  location            = var.location

}

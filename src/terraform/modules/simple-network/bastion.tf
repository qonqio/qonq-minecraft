locals {
  bastion_address_space = cidrsubnet(var.base_address_space, 4, 0)
}

resource "azurerm_subnet" "bastion" {

  count = var.enable_bastion ? 1 : 0

  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.bastion_address_space]
}

resource "azurerm_public_ip" "bastion" {

  count = var.enable_bastion ? 1 : 0

  name                = "pip-${var.name}-bastion"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "main" {

  count = var.enable_bastion ? 1 : 0

  name                = "bas-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion[0].id
    public_ip_address_id = azurerm_public_ip.bastion[0].id
  }
}


resource "azurerm_network_security_rule" "minecraft_java_port" {

  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group_name
  name                        = "${var.rule_name_prefix}-Game-Port"
  priority                    = var.priority
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = var.source_port_range
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = var.destination_address_prefix
  destination_port_range      = "25565"

}

resource "azurerm_network_security_rule" "rcon_port" {

  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group_name
  name                        = "${var.rule_name_prefix}-RCON-Port"
  priority                    = var.priority + 1
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = var.source_port_range
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = var.destination_address_prefix
  destination_port_range      = "25575"

}

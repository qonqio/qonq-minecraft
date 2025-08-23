output "subnet_id" {
  value = azurerm_subnet.default.id
}
output "nsg_id" {
  value = azurerm_network_security_group.main.id
}
output "nsg_name" {
  value = azurerm_network_security_group.main.name
}

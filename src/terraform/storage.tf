resource "azurerm_storage_account" "main" {
  name                     = "stdata${random_string.main.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
}

resource "azurerm_storage_container" "minecraft" {
  name                  = "minecraft"
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}

image_name             = "ubuntu-minecraft-bedrock"
azure_primary_location = "eastus2"
vm_size                = "Standard_DS2_v2"
resource_group_name    = "rg-qonq-gallery-dev"
marketplace_image = {
  offer     = "0001-com-ubuntu-server-jammy"
  publisher = "canonical"
  sku       = "22_04-lts"
}

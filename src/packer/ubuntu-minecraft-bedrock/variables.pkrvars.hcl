image_name             = "${image_name}"
azure_primary_location = "${primary_location}"
vm_size                = "${vm_size}"
resource_group_name    = "${resource_group_name}"
marketplace_image = {
  offer     = "0001-com-ubuntu-server-jammy"
  publisher = "canonical"
  sku       = "22_04-lts"
}
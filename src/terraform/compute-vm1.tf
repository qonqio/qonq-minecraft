resource "azurerm_public_ip" "vm1" {

  name                = "pip-${var.application_name}-${var.environment_name}-vm1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"

}

resource "azurerm_network_interface" "vm1" {
  name                = "nic-${var.application_name}-${var.environment_name}-vm1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm1.id
  }
}

data "azurerm_shared_image_version" "minecraft" {
  name                = var.image_version
  image_name          = "ubuntu-minecraft-bedrock"
  gallery_name        = var.azure_gallery_name
  resource_group_name = var.azure_gallery_resource_group
}

locals {
  clean_vm_name = replace("vm1${var.application_name}${var.environment_name}", "-", "")
}

resource "azurerm_linux_virtual_machine" "vm1" {

  name                = local.clean_vm_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  admin_username      = var.admin_user
  source_image_id     = data.azurerm_shared_image_version.minecraft.id

  network_interface_ids = [
    azurerm_network_interface.vm1.id,
  ]

  admin_ssh_key {
    username   = var.admin_user
    public_key = tls_private_key.vm1.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

}

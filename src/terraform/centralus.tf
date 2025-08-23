
resource "azurerm_resource_group" "centralus" {
  name     = "rg-${var.application_name}-${var.environment_name}-centralus"
  location = "centralus"
  tags     = local.all_tags
}

module "centralus_network" {
  source              = "./modules/simple-network"
  name                = "${var.application_name}-${var.environment_name}-centralus"
  resource_group_name = azurerm_resource_group.centralus.name
  location            = azurerm_resource_group.centralus.location
  base_address_space  = "10.64.4.0/22"
  enable_bastion      = true
}

module "bedrock_rules" {
  source                      = "./modules/nsg-rules-minecraft-bedrock"
  network_security_group_name = module.centralus_network.nsg_name
  resource_group_name         = azurerm_resource_group.centralus.name
  priority                    = 100

}

data "azurerm_shared_image_version" "bedrock_home" {
  name                = "2025.07.31"
  image_name          = "ubuntu-minecraft-bedrock"
  gallery_name        = var.azure_gallery_name
  resource_group_name = var.azure_gallery_resource_group
}

module "bedrock_home" {
  source              = "./modules/simple-vm"
  name                = "${var.application_name}-${var.environment_name}-bedrock-home"
  resource_group_name = azurerm_resource_group.centralus.name
  location            = azurerm_resource_group.centralus.location
  admin_user          = var.admin_user
  subnet_id           = module.centralus_network.subnet_id
  vm_size             = var.vm_size
  vm_image_id         = data.azurerm_shared_image_version.bedrock_home.id
  ssh_public_key      = tls_private_key.vm1.public_key_openssh
}

resource "azurerm_role_assignment" "bedrock_home_blob_data_owner" {

  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = module.bedrock_home.principal_id

}

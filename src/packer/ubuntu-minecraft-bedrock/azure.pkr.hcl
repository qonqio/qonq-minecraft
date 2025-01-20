source "azure-arm" "vm" {

  client_id       = var.arm_client_id
  subscription_id = var.arm_subscription_id
  tenant_id       = var.arm_tenant_id
  oidc_request_token = var.oidc_request_token
  oidc_request_url = var.oidc_request_url

  image_offer     = var.marketplace_image.offer
  image_publisher = var.marketplace_image.publisher
  image_sku       = var.marketplace_image.sku

  managed_image_name                = "${var.image_name}-${var.image_version}"
  managed_image_resource_group_name = var.resource_group_name
  shared_image_gallery_destination {
    resource_group = "rg-qonq-gallery-dev"
    gallery_name   = "galqonqgallerydev"
    image_name     = "ubuntu-minecraft-bedrock"
    image_version  = var.image_version
  }

  location                     = var.azure_primary_location
  communicator                 = "ssh"
  os_type                      = "Linux"
  vm_size                      = var.vm_size
  allowed_inbound_ip_addresses = [var.agent_ipaddress]

}

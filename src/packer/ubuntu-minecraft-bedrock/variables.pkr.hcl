variable "arm_subscription_id" {
  type    = string
}
variable "arm_tenant_id" {
  type    = string
}
variable "arm_client_id" {
  type    = string
}
variable "image_name" {
  type = string
}
variable "image_version" {
  type = string
}
variable "agent_ipaddress" {
  type = string
}
variable "azure_primary_location" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "marketplace_image" {
  type = object({
    offer     = string
    publisher = string
    sku       = string
  })
}
variable "oidc_request_token" {
  type = string
}
variable "oidc_request_url" {
  type = string
}

variable "priority" {
  type = number
}
variable "resource_group_name" {
  type = string
}
variable "network_security_group_name" {
  type = string
}
variable "rule_name_prefix" {
  type    = string
  default = "Minecraft-Java"
}
variable "source_port_range" {
  type    = string
  default = "*"
}
variable "source_address_prefix" {
  type    = string
  default = "*"
}
variable "destination_address_prefix" {
  type    = string
  default = "*"
}

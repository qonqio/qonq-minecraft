variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "location" {
  type = string
}
variable "additional_tags" {
  type = map(string)
  default = {}
}
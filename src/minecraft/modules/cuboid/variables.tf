variable "material" {
  type = string
}

variable "start_position" {
  type = object({
    x = number
    y = number
    z = number
  })
}

variable "width" {
  type = number
}

variable "height" {
  type = number
}

variable "depth" {
  type = number
}

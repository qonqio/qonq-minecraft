variable "material" {
  description = "The block material to use (e.g. minecraft:dirt)"
  type        = string
}

variable "start_position" {
  description = "The starting x, y, z position of the pillar"
  type = object({
    x = number
    y = number
    z = number
  })
}

variable "height" {
  description = "The number of blocks tall the pillar should be"
  type        = number
}

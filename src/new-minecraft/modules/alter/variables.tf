variable "start_position" {
  type = object({
    x = number
    y = number
    z = number
  })
}

variable "facing_mode" {
  description = "Whether stairs face 'inward' (toward center) or 'outward'"
  type        = string
  default     = "inward"
  validation {
    condition     = contains(["inward", "outward"], var.facing_mode)
    error_message = "facing_mode must be 'inward' or 'outward'."
  }
}

variable "material" {
  description = "Stairs block to use"
  type        = string
  default     = "minecraft:stone_brick_stairs"
}

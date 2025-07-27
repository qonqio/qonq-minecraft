locals {
  y_positions = [
    for i in range(var.height) : tostring(var.start_position.y + i)
  ]
}

resource "minecraft_block" "pillar" {
  for_each = toset(local.y_positions)

  material = var.material

  position = {
    x = var.start_position.x
    y = each.value
    z = var.start_position.z
  }
}

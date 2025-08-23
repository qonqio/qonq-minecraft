locals {
  # Cardinal offsets from the center
  dirs = {
    north = { dx = 0, dz = -1 }
    south = { dx = 0, dz = 1 }
    east  = { dx = 1, dz = 0 }
    west  = { dx = -1, dz = 0 }
  }

  # Opposite mapping to flip inward/outward facing
  opposite = { north = "south", south = "north", east = "west", west = "east" }
}

# Bottom layer (half=bottom), one stair in each cardinal direction
resource "minecraft_stairs" "altar_bottom" {
  for_each = local.dirs

  material = var.material
  position = {
    x = var.start_position.x + each.value.dx
    y = var.start_position.y
    z = var.start_position.z + each.value.dz
  }

  # Inward = face the center; Outward = face away from center
  facing = var.facing_mode == "outward" ? each.key : local.opposite[each.key]
  half   = "bottom"
  shape  = "straight"
}

# Top layer (half=top), placed one block higher, same positions
resource "minecraft_stairs" "altar_top" {
  for_each = local.dirs

  material = var.material
  position = {
    x = var.start_position.x + each.value.dx
    y = var.start_position.y + 1
    z = var.start_position.z + each.value.dz
  }

  facing = var.facing_mode == "outward" ? each.key : local.opposite[each.key]
  half   = "top" # upside-down
  shape  = "straight"
}

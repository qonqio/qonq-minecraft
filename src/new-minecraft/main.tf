resource "minecraft_fill" "line" {
  material = "minecraft:stone"

  start = {
    x = -254
    y = 69,
    z = -100
  }
  end = {
    x = -254
    y = 79,
    z = -100
  }
}

resource "minecraft_team" "red" {
  display_name = "Red Team"
  name         = "red"
  color        = "red"
}

resource "minecraft_team" "blue" {
  display_name = "Blue Team"
  name         = "blue"
  color        = "blue"
}

locals {
  red_count  = 2
  blue_count = 2
}

resource "minecraft_entity" "zombie_red" {
  count = 2
  type  = "zombie"
  position = {
    x = -254
    y = 69
    z = -103
  }
}

resource "minecraft_team_member" "zombie_red" {
  count     = 2
  team      = minecraft_team.red.id
  entity_id = minecraft_entity.zombie_red[count.index].id
}


resource "minecraft_entity" "zombie_blue" {
  count = 2
  type  = "zombie"
  position = {
    x = -254
    y = 69
    z = -103
  }
}

resource "minecraft_team_member" "zombie_blue" {
  count     = 2
  team      = minecraft_team.blue.id
  entity_id = minecraft_entity.zombie_blue[count.index].id
}

resource "minecraft_team_member" "markti" {
  team   = minecraft_team.red.id
  player = "markti22"
}

resource "minecraft_chest" "chest1" {

  count = 0

  size = "double"

  position = {
    x = -254
    y = 69
    z = -102
  }

}

resource "minecraft_bed" "bed1" {

  count = 0

  material = "minecraft:red_bed"

  position = {
    x = -254
    y = 69
    z = -104
  }
  direction = "east"

}

module "alter" {
  source = "./modules/alter"

  count = 1

  start_position = {
    x = -254
    y = 69
    z = -104
  }
  material = "minecraft:stone_brick_stairs"
}

resource "minecraft_stairs" "bed1" {

  count = 0

  material = "minecraft:oak_stairs"

  position = {
    x = -254
    y = 69
    z = -106
  }
  facing      = "east"
  half        = "bottom"
  shape       = "straight"
  waterlogged = false

}

resource "minecraft_stairs" "bed2" {

  count = 0

  material = "minecraft:oak_stairs"

  position = {
    x = -254
    y = 69
    z = -107
  }
  facing      = "north"
  half        = "bottom"
  shape       = "straight"
  waterlogged = false

}
resource "minecraft_stairs" "bed3" {

  count = 0

  material = "minecraft:oak_stairs"

  position = {
    x = -254
    y = 69
    z = -108
  }
  facing      = "north"
  half        = "top"
  shape       = "straight"
  waterlogged = false

}
resource "minecraft_stairs" "bed4" {

  count = 0

  material = "minecraft:oak_stairs"

  position = {
    x = -254
    y = 69
    z = -105
  }
  facing      = "east"
  half        = "top"
  shape       = "straight"
  waterlogged = false

}

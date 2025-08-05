locals {
  origin = var.start_position
}

module "wall_top" {
  source = "../wall-with-door"
  start_position = {
    x = local.origin.x + 1
    y = local.origin.y
    z = local.origin.z
  }
  material      = "minecraft:oak_planks"
  door_material = "minecraft:oak_door"
  direction     = "east"
}

module "wall_bottom" {
  source = "../wall-with-window"
  start_position = {
    x = local.origin.x + 1
    y = local.origin.y
    z = local.origin.z + 5
  }
  material       = "minecraft:oak_planks"
  glass_material = "minecraft:glass"
  direction      = "east"
}

module "wall_left" {
  source = "../wall-with-window"
  start_position = {
    x = local.origin.x
    y = local.origin.y
    z = local.origin.z + 1
  }
  material       = "minecraft:oak_planks"
  glass_material = "minecraft:glass"
  direction      = "north"
}

module "wall_right" {
  source = "../wall-with-window"
  start_position = {
    x = local.origin.x + 5
    y = local.origin.y
    z = local.origin.z + 1
  }
  material       = "minecraft:oak_planks"
  glass_material = "minecraft:glass"
  direction      = "north"
}

module "roof" {
  source = "../cuboid"

  material = "minecraft:oak_planks" # or slabs, or stone, etc.

  start_position = {
    x = local.origin.x
    y = local.origin.y + 4
    z = local.origin.z
  }

  width  = 6
  length = 1
  depth  = 6
}

resource "minecraft_block" "door_right" {
  material = "minecraft:crafting_table"
  position = {
    x = local.origin.x + 4
    y = local.origin.y
    z = local.origin.z + 1
  }
}

resource "minecraft_block" "door_left" {
  material = "minecraft:white_wool"
  position = {
    x = local.origin.x + 1
    y = local.origin.y
    z = local.origin.z + 1
  }
}

resource "minecraft_block" "chest1" {
  material = "minecraft:chest"
  position = {
    x = local.origin.x + 1
    y = local.origin.y
    z = local.origin.z + 4
  }
}
resource "minecraft_block" "chest2" {
  material = "minecraft:chest"
  position = {
    x = local.origin.x + 2
    y = local.origin.y
    z = local.origin.z + 4
  }
}

// -1531, 68, -1177

resource "minecraft_block" "stone" {
  material = "minecraft:diamond_block"

  position = {
    x = -1531
    y = 68
    z = -1178
  }

}
resource "minecraft_block" "dirt" {
  material = "minecraft:dirt"

  position = {
    x = -1531
    y = 68
    z = -1177
  }

}

module "p1" {
  source = "./modules/pillar"

  material       = "minecraft:dirt"
  start_position = { x = -1532, y = 66, z = -1177 }
  length         = 3
}

module "island_near_nether_portal" {
  source = "./modules/cuboid"

  material       = "minecraft:dirt"
  start_position = { x = -1564, y = 60, z = -1181 }
  length         = 3
  width          = 8
  depth          = 8
}

module "w1" {
  source = "./modules/small-hut"

  material       = "minecraft:oak_planks"
  glass_material = "minecraft:glass_pane"
  start_position = {
    x = -1562,
    y = 63,
    z = -1180
  }

}


module "pyramid" {
  source = "./modules/solid-pyramid"

  material = "minecraft:gold_block"

  start_position = {
    x = -1650,
    y = 62,
    z = -1100
  }
  length = 20

}

module "pyramid2" {

  count = 1

  source = "./modules/pyramid"

  material = "minecraft:diamond_block"

  start_position = {
    x = -1600,
    y = 62,
    z = -1101
  }
  length = 20

}

module "train_track" {
  source = "./modules/train-track"

  start_position = {
    x = -1560
    y = 62
    z = -1170
  }
  length    = 200
  direction = "north"

}


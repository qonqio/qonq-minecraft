

module "kcdc_pyramid" {

  count = 1

  source = "./modules/pyramid"

  material = "minecraft:gold_block"

  start_position = {
    x = -1505,
    y = 62,
    z = -1151
  }
  length = 20

}


module "w4" {

  count = 1

  source = "./modules/small-hut"

  material       = "minecraft:oak_planks"
  glass_material = "minecraft:glass_pane"
  start_position = {
    x = -271,
    y = 69,
    z = -135
  }

}

resource "minecraft_block" "bed1" {
  material = "minecraft:white_bed"

  position = {
    x = -262
    y = 68
    z = -128
  }

  depends_on = [minecraft_block.bed2]
}
resource "minecraft_block" "bed2" {
  material = "minecraft:white_bed"

  position = {
    x = -262
    y = 68
    z = -129
  }
}


module "pyramid4" {

  count = 1

  source = "./modules/solid-pyramid"

  material = "minecraft:diamond_block"
  length   = 20

  start_position = {
    x = -350,
    y = 62,
    z = -144
  }

}

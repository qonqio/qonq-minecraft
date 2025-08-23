terraform {
  required_providers {
    minecraft = {
      source  = "markti/minecraft"
      version = "~> 0.0.21"
    }
  }
}

provider "minecraft" {
  address  = "${var.minecraft_server}:${var.rcon_port}"
  password = var.rcon_password
}

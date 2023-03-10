terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.0"
    }
  }
}

provider "docker" {
  registry_auth {
    address = var.address
  }
}

resource "docker_image" "image" {
  name         = join("/", [var.address, var.registry, var.repository])
  keep_locally = true
  build {
    context = join("/", [path.cwd, var.context])
    tag     = var.tag
  }
}

resource "docker_registry_image" "image" {
  name          = docker_image.image.name
  keep_remotely = false
  depends_on = [
    docker_image.image
  ]
}

terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = ">= 0.0.21"
    }
  }
}

provider "fly" {
  useinternaltunnel    = true
  internaltunnelorg    = var.orginization
  internaltunnelregion = var.regions[0]
}

resource "fly_app" "application" {
  name = var.name
  org  = "personal"
}

resource "fly_ip" "ipv4" {
  app        = var.name
  type       = "v4"
  depends_on = [fly_app.application]
}

resource "fly_ip" "ipv6" {
  app        = var.name
  type       = "v6"
  depends_on = [fly_app.application]
}

resource "fly_machine" "machine" {
  for_each = toset(var.regions)
  app      = var.name
  region   = each.value
  name     = "${var.name}-${each.value}"
  image    = var.image
  env      = var.env
  services = [
    {
      ports = [
        {
          port     = 443
          handlers = ["tls", "http"]
        },
        {
          port     = 80
          handlers = ["http"]
        }
      ]
      "protocol" : "tcp",
      "internal_port" : var.internal_port
    },
  ]
  cpus       = 1
  memorymb   = 256
  depends_on = [fly_app.application]
}

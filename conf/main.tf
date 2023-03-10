variable "name" {
  type     = string
  nullable = false
}

module "cockroach" {
  source = "./modules/cockroach"

  cluster_name = var.name
}

module "fly" {
  source = "./modules/fly"

  name    = var.name
  regions = ["lhr", "syd"]
  image   = module.docker.image
}

module "docker" {
  source = "./modules/docker"

  repository = var.name
  tag        = ["0.0.1"]
}

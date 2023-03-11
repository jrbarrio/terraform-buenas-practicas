locals {
  whitelist_cidr = ["0.0.0.0/0"]
}

module "app" {
  source = "./app"

  whitelist_cidr = local.whitelist_cidr
}
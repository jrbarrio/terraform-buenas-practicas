locals {
  whitelist_cidr = ["0.0.0.0/0"]
}

module "app" {
  source = "./app"

  whitelist_cidr = local.whitelist_cidr
  bucket_name = var.bucket_name
  dynamodb_name = var.dynamodb_name

  environment = var.environment
  project = var.project
}
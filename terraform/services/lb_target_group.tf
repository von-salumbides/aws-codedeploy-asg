module "target-group-client" {
  source    = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-target-group"
  project   = var.project
  env       = var.env
  vpc       = var.vpc
  purpose   = "client"
  tg_config = "TG"
}

module "target-group-api" {
  source    = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-target-group"
  project   = var.project
  env       = var.env
  vpc       = var.vpc
  purpose   = "api"
  tg_config = "TG"
}
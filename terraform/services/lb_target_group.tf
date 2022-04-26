module "target-group-blue" {
  source    = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-target-group"
  project   = var.project
  env       = var.env
  vpc       = var.vpc
  purpose   = "blue"
  tg_config = "TG"
}

module "target-group-green" {
  source    = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-target-group"
  project   = var.project
  env       = var.env
  vpc       = var.vpc
  purpose   = "green"
  tg_config = "TG"
}
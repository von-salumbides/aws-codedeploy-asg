module "target-group" {
  source    = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-target-group"
  project   = var.project
  env       = var.env
  vpc       = var.vpc
  purpose   = "codedeploy"
  tg_config = "TG"
}
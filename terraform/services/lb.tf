module "lb" {
  source           = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-app"
  project          = var.project
  env              = var.env
  security_group   = module.security-group-alb.id
  subnet_list      = var.subnet_list
  region           = var.region
  aws_account      = var.aws_account
  purpose          = "ext"
  internal         = false
  is_https_enabled = false
  certificate      = ""
}
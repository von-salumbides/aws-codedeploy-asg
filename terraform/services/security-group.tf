//SECURITY GROUP(S)
module "security-group-ec2" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-security-group?ref=v0.1.1"
  config  = "EC2"
  vpc     = var.vpc
  env     = var.env
  project = var.project
  source_id_var = {
    ALB = module.security-group-alb.id
  }
}

//SECURITY GROUP(S)
module "security-group-alb" {
  source        = "git::https://github.com/von-salumbides/terraform-module.git//aws-security-group?ref=v0.1.1"
  config        = "ALB"
  vpc           = var.vpc
  env           = var.env
  project       = var.project
  source_id_var = {}
}
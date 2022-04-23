module "asg-role" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-iam-role"
  project = var.project
  env     = var.env
  purpose = "asg"
  config  = "trust_services"
}
module "asg" {
  source                 = "git::https://github.com/von-salumbides/terraform-module.git//aws-autoscaling-group"
  asg_config             = "ASG"
  ecs_cluster_name       = ""
  env                    = var.env
  region                 = var.region
  project                = var.project
  subnet_list            = var.subnet_list
  profile_arn            = module.asg-role.profile_arn
  vpc_security_group_ids = module.security-group-ec2.id
}
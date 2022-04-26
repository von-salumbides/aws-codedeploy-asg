module "asg-green" {
  source                 = "git::https://github.com/von-salumbides/terraform-module.git//aws-autoscaling-group"
  asg_config             = "ASG"
  ecs_cluster_name       = ""
  env                    = var.env
  region                 = var.region
  project                = "devops-green"
  subnet_list            = var.subnet_list
  profile_arn            = module.asg-role.profile_id
  vpc_security_group_ids = module.security-group-ec2.id
}

module "asg-blue" {
  source                 = "git::https://github.com/von-salumbides/terraform-module.git//aws-autoscaling-group"
  asg_config             = "ASG"
  ecs_cluster_name       = ""
  env                    = var.env
  region                 = var.region
  project                = "devops-blue"
  subnet_list            = var.subnet_list
  profile_arn            = module.asg-role.profile_id
  vpc_security_group_ids = module.security-group-ec2.id
}
module "codedeploy-app" {
  source  = "git::https://github.com/von-salumbides/terraform-module.git//aws-codedeploy-app"
  env     = var.env
  project = var.project
}

resource "aws_codedeploy_deployment_group" "example" {
  app_name              = module.codedeploy-app.name
  deployment_group_name = "devops-poc"
  service_role_arn      = module.asg-role.arn
  autoscaling_groups    = [module.asg-blue.name]
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
  load_balancer_info {
    target_group_info {
      name = module.target-group-blue.name
    }
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "STOP_DEPLOYMENT"
      wait_time_in_minutes = 60
    }
    green_fleet_provisioning_option {
      action = "DISCOVER_EXISTING"
    }
    terminate_blue_instances_on_deployment_success {
      action = "KEEP_ALIVE"
    }
  }
}
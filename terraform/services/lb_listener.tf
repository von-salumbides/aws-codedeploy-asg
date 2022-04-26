module "listener" {
  source            = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-listener"
  port              = 80
  config            = "RULES"
  load_balancer_arn = module.lb.arn
  target-group = {
    blue  = module.target-group-blue.arn
    green = module.target-group-green.arn
  }
  depends_on = [
    module.lb,
    module.target-group-blue,
    module.target-group-green
  ]
}

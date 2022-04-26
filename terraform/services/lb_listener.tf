module "listener" {
  source            = "git::https://github.com/von-salumbides/terraform-module.git//aws-lb-listener"
  port              = 80
  config            = "RULES"
  load_balancer_arn = module.lb.arn
  target-group = {
    api    = module.target-group-api.arn
    client = module.target-group-client.arn
  }
  depends_on = [
    module.lb,
    module.target-group-api,
    module.target-group-client
  ]
}

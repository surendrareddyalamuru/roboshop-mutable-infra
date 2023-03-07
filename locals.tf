locals {
  app_private_subnets = [for k, v in module.vpc.private_subnets : "subnets" => v.subnets]
}
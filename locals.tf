locals {
  app_private_subnets      = lookup(lookup(lookup({ for k, v in module.vpc.private_subnets : "subnets" => v.subnets }, "subnets", null), "app", null), "subnets", null)
}
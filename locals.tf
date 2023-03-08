#locals {
#  private_subnets      = lookup({ for k, v in module.vpc.private_subnets : "subnets" => v.subnets }, "subnets", null)
#}
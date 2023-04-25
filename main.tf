module "vpc" {
  for_each = var.vpc
  source = "github.com/surendrareddyalamuru/tf-module-vpc"
  cidr_block                = each.value.cidr_block
  additional_cidr_block     = each.value.additional_cidr_block
  private_subnets           = each.value.private_subnets
  public_subnets            = each.value.public_subnets
  subnet_availability_zones = each.value.subnet_availability_zones
  env = var.env
  management_vpc = var.management_vpc
  private_zone_id = var.private_zone_id
}

module "docdb" {
  for_each = var.docdb
  source = "github.com/surendrareddyalamuru/tf-module-docdb"
  engine = each.value.engine
  name = each.key
  env = var.env
  subnets = flatten([for i, j in module.vpc : j.private_subnets["backend"]["subnets"][*].id])
  nodes               = each.value.nodes
  skip_final_snapshot = each.value.skip_final_snapshot
  BASTION_NODE = var.BASTION_NODE
  vpc_cidr = element([for i, j in module.vpc : j.vpc_cidr], 0)
  vpc_id   = element([for i, j in module.vpc : j.vpc_id], 0)
}


module "rds" {
  for_each = var.rds
  source = "github.com/surendrareddyalamuru/tf-module-rds"
  name = each.key
  env = var.env
  subnets = flatten([for i, j in module.vpc : j.private_subnets["backend"]["subnets"][*].id])
  allocated_storage   = each.value.allocated_storage
  engine              = each.value.engine
  engine_version      = each.value.engine_version
  instance_class      = each.value.instance_class
  skip_final_snapshot = each.value.skip_final_snapshot
  BASTION_NODE = var.BASTION_NODE
  vpc_cidr = element([for i, j in module.vpc : j.vpc_cidr], 0)
  vpc_id   = element([for i, j in module.vpc : j.vpc_id], 0)
  nodes               = each.value.nodes
}

module "elasticache" {
  for_each = var.elasticache
  source   = "github.com/surendrareddyalamuru/tf-module-elasticache"
  name     = each.key
  env      = var.env
  subnets  = flatten([for i, j in module.vpc : j.private_subnets["backend"]["subnets"][*].id])
  engine          = each.value.engine
  engine_version  = each.value.engine_version
  node_type       = each.value.node_type
  num_cache_nodes = each.value.num_cache_nodes
  vpc_cidr = element([for i, j in module.vpc : j.vpc_cidr], 0)
  vpc_id   = element([for i, j in module.vpc : j.vpc_id], 0)
}

module "rabbitmq" {
  for_each = var.rabbitmq
  source   = "github.com/surendrareddyalamuru/tf-module-rabbitmq"
  name     = each.key
  env      = var.env
  subnets  = flatten([for i, j in module.vpc : j.private_subnets["backend"]["subnets"][*].id])
  instance_type   = each.value.instance_type
  private_zone_id = var.private_zone_id
  BASTION_NODE    = var.BASTION_NODE
  vpc_id          = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr        = element([for i, j in module.vpc : j.vpc_cidr], 0)
}

module "apps" {
  for_each             = var.apps
  source   = "github.com/surendrareddyalamuru/tf-module-mutable-app-setup"
  subnets  = each.key == "frontend" ? flatten([for i, j in module.vpc : j.private_subnets["frontend"]["subnets"][*].id]) : flatten([for i, j in module.vpc : j.private_subnets["app"]["subnets"][*].id])
  env = var.env
  name                 = each.key
  instance_type        = each.value.instance_type
  min_size             = each.value.min_size
  max_size             = each.value.max_size
  lb_listener_priority = each.value.lb_listener_priority
  type                 = each.value.type
  vpc_id               = element([for i, j in module.vpc : j.vpc_id], 0)
  BASTION_NODE         = var.BASTION_NODE
  app_port_no          = each.value.app_port_no
  PROMETHEUS_NODE      = var.PROMETHEUS_NODE
  vpc_cidr             = element([for i, j in module.vpc : j.vpc_cidr], 0)
  alb                  = module.alb
  private_zone_id      = var.private_zone_id
  public_zone_id       = var.public_zone_id
  public_dns_name      = try(each.value.public_dns_name, null)
  ACM_ARN              = var.ACM_ARN
}

module "alb" {
  source   = "github.com/surendrareddyalamuru/tf-module-alb"
  for_each = local.merged_alb
  env      = var.env
  subnets  = each.value.subnets
  name     = each.key
  vpc_id   = element([for i, j in module.vpc : j.vpc_id], 0)
  vpc_cidr = element([for i, j in module.vpc : j.vpc_cidr], 0)
  internal = each.value.internal
}






#output "database_private_subnets" {
#  value = local.database_private_subnets[*].id
#}

#output "app_subnets" {
#  value = [for i, j in module.vpc : j.private_subnets["app"]["subnets"][*].id]
#}
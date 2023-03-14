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
}

module "docdb" {
  for_each = var.docdb
  source = "github.com/surendrareddyalamuru/tf-module-docdb"
  engine = each.value.engine
  name = each.key
  env = var.env
  subnets = flatten([for i, j in module.vpc : j.private_subnets["backend"]["subnets"][*].id])
}

#
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
}


#output "database_private_subnets" {
#  value = local.database_private_subnets[*].id
#}

output "app_subnets" {
  value = [for i, j in module.vpc : j.private_subnets["app"]["subnets"][*].id]
}
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
#
#module "docdb" {
#  for_each = var.docdb
#  source = "github.com/surendrareddyalamuru/tf-module-docdb"
#  docdb = var.docdb
#  env = var.env
#  subnets = local.database_private_subnets[*].id
#}

#
#module "rds" {
#  for_each = var.docdb
#  source = "github.com/surendrareddyalamuru/tf-module-rds"
#  docdb = var.rds
#  env = var.env
#  subnets = local.database_private_subnets[*].id
#}


#output "database_private_subnets" {
#  value = local.database_private_subnets[*].id
#}

output "subnets" {
  value = lookup(module.vpc, "private_subnets", null)
}
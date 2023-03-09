module "vpc" {
  source = "github.com/surendrareddyalamuru/tf-module-vpc"
  vpc = var.vpc
  env = var.env
  management_vpc = var.management_vpc
}

module "docdb" {
  source = "github.com/surendrareddyalamuru/tf-module-docdb"
  docdb = var.docdb
  env = var.env
  subnets = local.database_private_subnets[0].id
}


#output "database_private_subnets" {
#  value = local.database_private_subnets[0].id
#}

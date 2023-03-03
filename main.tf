module "vpc" {
  source = "github.com/surendrareddyalamuru/tf-module-vpc"
  for_each = var.vpc
  env = var.env
  management_vpc = var.management_vpc
}

module "vpc" {
  source = "github.com/surendrareddyalamuru/tf-module-vpc"
  vpc = var.vpc
  env = var.env
  management_vpc = var.management_vpc
}


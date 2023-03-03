module "vpc" {
  source = "github.com/surendrareddyalamuru/tf-module-vpc"
  vpc = var.vpc
  env = var.env
  management_vpc = var.management_vpc
  private_subnets           = each.value.private_subnets
  public_subnets            = each.value.public_subnets
}

module "vpc" {
  source = "github.com/surendrareddyalamuru/tf-module-vpc"
  vpc_cidr = var.vpc_cidr
}

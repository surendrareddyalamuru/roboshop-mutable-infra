module "vpc" {
  source = "https://github.com/surendrareddyalamuru/tf-module-vpc"
  vpc_cidr = var.vpc_cidr
}

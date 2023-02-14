module "vpc" {
  source = "github.com/surendrareddyalamuru/tf-module-vpc"
  vpc = var.vpc
  ENV = var.env
}

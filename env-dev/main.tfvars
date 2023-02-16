vpc = {
  vpc1 = {
    cidr_block = "10.0.0.0/16"
    additional_cidr_block = []
    subnets = {
      frontend = {
        cidr_block = [ "10.0.0.0/24", "10.0.1.0/24" ]
        name = "frontend"
      }
      backend = {
        cidr_block = [ "10.0.2.0/24", "10.0.3.0/24" ]
        name = "backend"
      }
      app = {
        cidr_block = [ "10.0.4.0/24", "10.0.5.0/24" ]
        name = "app"
      }
    }

  }
}

env = "dev"
vpc = {
  vpc1 = {
    cidr_block = "10.0.0.0/16"
    additional_cidr_block = []
    private_subnets = {
      frontend = {
        cidr_block = [ "10.0.0.0/24", "10.0.1.0/24" ]
        name = "frontend"
        attach_to = "ngw"
      }
      backend = {
        cidr_block = [ "10.0.2.0/24", "10.0.3.0/24" ]
        name = "backend"
        attach_to = "ngw"
      }
      app = {
        cidr_block = [ "10.0.4.0/24", "10.0.5.0/24" ]
        name = "app"
        attach_to = "ngw"
      }
    }
    public_subnets = {
      public = {
        cidr_block = ["10.0.255.0/24", "10.0.254.0/24"]
        name       = "public"
        attach_to  = "igw"
      }
    }
    subnet_availability_zones = ["us-east-1a", "us-east-1b"]
  }
}

management_vpc = {
  vpc_id = "vpc-0c72cf11edd3d54ec"
  route_table = "rtb-090ce6f5f29acbc3d"
  vpc_cidr = "172.31.0.0/16"
}

env = "dev"
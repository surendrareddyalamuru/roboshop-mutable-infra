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

docdb = {
  db1 = {
    engine = "docdb"
  }
}

rds = {
  db1 = {
    allocated_storage   = 10
    engine              = "aurora-mysql"
    engine_version      = "5.7.mysql_aurora.2.11.0"
    instance_class      = "db.t3.micro"
    skip_final_snapshot = true

  }
}

elasticache = {
  ec1 = {
    engine          = "redis"
    engine_version  = "6.2"
    node_type       = "cache.t3.micro"
    num_cache_nodes = 1
  }

}

rabbitmq = {
  mq1 = {
    instance_type = "t3.micro"
  }
}

env = "dev"

apps = {
  cart = {
    instance_type        = "t3.micro"
    max_size             = 1
    min_size             = 1
    app_port_no          = 8080
    lb_listener_priority = 100
    type                 = "backend"
  }
}

BASTION_NODE = "172.31.12.25/32"
private_zone_id = "Z038950339R30I8446RWR"

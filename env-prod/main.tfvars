vpc = {
  vpc1 = {
    cidr_block = "10.200.0.0/16"
    additional_cidr_block = []
    private_subnets = {
      frontend = {
        cidr_block = [ "10.200.0.0/24", "10.200.1.0/24" ]
        name = "frontend"
        attach_to = "ngw"
      }
      backend = {
        cidr_block = [ "10.200.2.0/24", "10.200.3.0/24" ]
        name = "backend"
        attach_to = "ngw"
      }
      app = {
        cidr_block = [ "10.200.4.0/24", "10.200.5.0/24" ]
        name = "app"
        attach_to = "ngw"
      }
    }
    public_subnets = {
      public = {
        cidr_block = ["10.200.255.0/24", "10.200.254.0/24"]
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
    skip_final_snapshot = true
    nodes = {
      one = {
        instance_class = "db.t3.medium"
      }
    }
  }
}

rds = {
  db1 = {
    allocated_storage   = 10
    engine              = "aurora-mysql"
    engine_version      = "5.7.mysql_aurora.2.11.1"
    instance_class      = "db.t3.micro"
    skip_final_snapshot = true
    nodes = {
      one = {
        instance_class = "db.t3.small"
      }
    }

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

env = "prod"

apps = {
  cart = {
    instance_type        = "t3.micro"
    max_size             = 5
    min_size             = 2
    app_port_no          = 8080
    lb_listener_priority = 100
    type                 = "backend"
  }
  catalogue = {
    instance_type        = "t3.micro"
    max_size             = 5
    min_size             = 2
    app_port_no          = 8080
    lb_listener_priority = 101
    type                 = "backend"
  }
  user = {
    instance_type        = "t3.micro"
    max_size             = 5
    min_size             = 2
    app_port_no          = 8080
    lb_listener_priority = 102
    type                 = "backend"
  }
  shipping = {
    instance_type        = "t3.micro"
    max_size             = 5
    min_size             = 2
    app_port_no          = 8080
    lb_listener_priority = 103
    type                 = "backend"
  }
  payment = {
    instance_type        = "t3.micro"
    max_size             = 5
    min_size             = 2
    app_port_no          = 8080
    lb_listener_priority = 104
    type                 = "backend"
  }
  frontend = {
    instance_type        = "t3.micro"
    max_size             = 5
    min_size             = 2
    app_port_no          = 80
    type                 = "frontend"
    lb_listener_priority = 100
    public_dns_name      = "www"
  }
}

alb = {
  public = {
    internal = false
  }
  private = {
    internal = true
  }
}

BASTION_NODE = "172.31.12.25/32"
private_zone_id = "Z038950339R30I8446RWR"
public_zone_id = "Z01347193MNE0I2QTZ9TX"
PROMETHEUS_NODE = "172.31.7.10/32"


ACM_ARN = "arn:aws:acm:us-east-1:762942456166:certificate/b1be80cd-448e-4b4b-b206-b7bbfdeb4ec2"
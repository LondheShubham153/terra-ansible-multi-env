module "dev" {
  source = "./infrastructure"
  env = "dev"

  vpc_config = {
      cidr = "10.0.0.0/16"
      name = "my-vpc"  
    }

  subnet_config = [
      {
        name = "subnet-1"
        cidr = "10.0.1.0/24"
        az = "ap-south-1a"
      },
      {
        name = "subnet-2"
        cidr = "10.0.2.0/24"
        az = "ap-south-1b"
      },
      {
        name = "subnet-3"
        cidr = "10.0.3.0/24"
        az = "ap-south-1b"
      }]

  ec2_config = [
    {
      name = "dev-1"
      ami = "ami-053b12d3152c0cc71"
      instance_type = "t2.micro"
      storage_size = 12
    },
    {
      name = "dev-2"
      ami = "ami-053b12d3152c0cc71"
      instance_type = "t2.micro"
      storage_size = 12
    },
    {
      name = "dev-3"
      ami = "ami-053b12d3152c0cc71"
      instance_type = "t2.micro"
      storage_size = 12
    }] 
}

output "dev_infra_ec2_public_ips" {
  value = module.dev.ec2_public_ips
}



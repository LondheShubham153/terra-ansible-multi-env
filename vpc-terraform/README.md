## Multi-Environment Infrastructure Project

This repository provides a Terraform configuration to set up infrastructure for multiple environments. It creates a separate Virtual Private Cloud (VPC) along with subnets, an internet gateway, route tables,route table association and EC2 instances for each environment. The module design ensures flexibility and reusability.

## Features

- **VPC Creation**: Separate VPC for each environment.
- **Subnets**: Multiple subnets for efficient networking.
- **Internet Gateway**: Allows internet access for resources in public subnets.
- **Route Tables**: Configured for proper routing of traffic.
- **EC2 Instance**: Deploys an instance within the created VPC.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your system.
- AWS credentials configured for Terraform.
- Sufficient IAM permissions to create VPC, subnets, and EC2 instances.

## How to Use

### Step 1: Clone the Repository

```bash
git clone https://github.com/joakim077/multi-env-infra-project.git
cd multi-env-infra-project
```

### Step 2: Initialize Terraform

Navigate to the terraform directory and initialize Terraform.

```bash
cd terraform
terraform init
```

### Step 3: Provide Input Variables

You can provide input variables through the root module or terraform.tfvars file in the environment directory or as CLI arguments.

Here is an example of providing variables using root module

#### Example `main.tf`

```hcl
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
```

#### Variables Explained
- **vpc_config**: An Object that contains name and CIDR of VPC.
- **subnet_config**: List of Objects that contains name, CIDR and availability zone of subnets.
- **ec2_config**: List of objects that contains name, AMI, instance type and root volume size (GB).


### Step 4: Apply the Configuration

Run the following command to create the resources:

```bash
terraform apply
```

Review the planned changes and confirm by typing `yes`.

### Step 5: Verify the Resources

After successful execution, you can view the created resources in the AWS Management Console.

### Step 6: Destroy the Resources

To delete all resources created by Terraform, run:

```bash
terraform destroy
```

## Outputs

The module provides the public IP of EC2 instance.

#### Example 
```hcl
output "dev_infra_ec2_public_ips" {
  value = module.dev.ec2_public_ips
}
```


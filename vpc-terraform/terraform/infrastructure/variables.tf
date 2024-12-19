# Environment
variable "env" {
  description = "This is the environment name eg. dev/stg/prd"
  type = string
}

# Configure VPC
variable "vpc_config" {
  description = "name and CIDR of VPC"
  type = object({
    cidr = string
    name = string
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr))
    error_message = "Invalid CIDR - $ {var.vpc_config.cidr}"
  }
}

# Configure Subnets
# variable "subnet_config1" {
#   description = "CIDR and AZ of subnets"
#   type = map(object({
#     cidr = string
#     az = string
#   }))

#   validation {
#     condition = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr))])
#     error_message = "Invalid CIDR for Subnet"
#   }
# }

variable "subnet_config" {
  description = "CIDR and AZ of subnets"
  type = list(object({
    name = string
    cidr = string
    az = string
  }))
  validation {
    condition = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr))])
    error_message = "Invalid CIDR for Subnet"
  }
}



# EC2 configuration

variable "ec2_config" {
  description = "EC2 configration"

  type = list(object({
    name = string
    instance_type = string
    ami = string
    storage_size = number
  }))  
}

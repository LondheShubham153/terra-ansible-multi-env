resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr
  tags = {
    Name = "${var.env}-${var.vpc_config.name}"
  }
}

resource "aws_subnet" "subnets" {
  vpc_id = aws_vpc.main.id
  count = length(var.subnet_config)
  cidr_block = var.subnet_config[count.index].cidr
  availability_zone = var.subnet_config[count.index].az

  tags = {
    Name = "${var.env}-${var.subnet_config[count.index].name}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-my-igw"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "name" {
  count = length((var.subnet_config))
  subnet_id = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.main.id
  depends_on = [ aws_route_table.main ]
}
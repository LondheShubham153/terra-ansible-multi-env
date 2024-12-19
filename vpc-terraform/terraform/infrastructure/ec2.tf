resource "aws_key_pair" "main" {
  key_name   = "${var.env}-instance-key"
  public_key = file("./infrastructure/key_junoon.pub")
}
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
  description = "allow SSH, HTTP and HTTPS"
  name = "${var.env}-sg"

  ingress {
    description = "allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    description = "allow all"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-sg"
    Environment = var.env
  }
}

resource "aws_instance" "main" {
  count = length(var.ec2_config)
  ami = var.ec2_config[count.index].ami
  instance_type = var.ec2_config[count.index].instance_type
  associate_public_ip_address = true
  key_name = aws_key_pair.main.key_name
  vpc_security_group_ids = [ aws_security_group.main.id ]

  subnet_id = element(aws_subnet.subnets[*].id, count.index % length(aws_subnet.subnets))  
  tags = {
    Name = var.ec2_config[count.index].name
    environment = var.env
  }

  root_block_device {
    volume_size = var.ec2_config[count.index].storage_size
    volume_type = "gp3"
  }
}

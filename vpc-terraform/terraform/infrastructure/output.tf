output "vpc_id" {
    value = aws_vpc.main.id
}

output "ec2_public_ips" {
    value = aws_instance.main[*].public_ip
    description = "Public IP addresses of AWS EC2 instances"
}
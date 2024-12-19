resource "aws_s3_bucket" "main" {
  bucket = "${var.env}-env-terra-ansible-iaac-bucket-000"
  tags = {
    Name = "${var.env}-env-terra-ansible-iaac-bucket-000"
    environment = var.env
  }
}
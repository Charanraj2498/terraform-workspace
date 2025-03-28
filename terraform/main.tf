# Fetch the current workspace
locals {
  workspace_name = terraform.workspace
}

# Create an S3 Bucket with a unique name
resource "aws_s3_bucket" "bucket" {
  bucket = "${local.workspace_name}-ck-123"
  acl    = "private"
}

# Create an EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-071226ecf16aa7d96"  # Amazon Linux 2 AMI (Change as per region)
  instance_type = lookup(var.instance_type, local.workspace_name, "t2.micro")

  tags = {
    Name = "${local.workspace_name}-ck"
  }
}


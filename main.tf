# Define the terraform providers required
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# Define AWS settings
provider "aws" {
  profile = "default"
  region = "us-east-1" 
}

# Null-resource with a local executioner (not best practice...)
resource "null_resource" "shell_script_for_ics" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "bash ./mimics_script.sh"
  }
}

# Misconfigured S3 bucket
resource "aws_s3_bucket" "my_private_bucket" {
  bucket = "my-unique-bucket-name" 

  tags = {
    Name        = "My Private Bucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_private_bucket.id

  block_public_acls   = false
  ignore_public_acls  = false
  block_public_policy = false
  restrict_public_buckets = false
}

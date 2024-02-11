provider "aws" {
  region = "us-east-1" 
}

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

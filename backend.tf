terraform {
  backend "s3" {
    bucket         = "alex-terraform-state-v5"    # ← EXACT ca pe S3!
    key            = "vpc-ec2/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
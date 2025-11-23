terraform {
  backend "s3" {
    bucket         = "alex-terraform-state-v5"
    key            = "vpc-ec2/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    # ȘTERGE dynamodb_table temporar!
  }
}
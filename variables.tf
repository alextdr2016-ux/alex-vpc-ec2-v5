variable "region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS region"
}

variable "vpc_name" {
  type        = string
  default     = "alex_vpc_v5"
  description = "The name of the vpc resource"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "vpc cidr"
}


variable "public_subnet_name" {
  type        = string
  default     = "alex_public_subnet_v5"
  description = "The name of the public subnet"
}

variable "public_subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "public subnet cidr"
}

variable "instance_type" {
  type        = string
  default     = "t3.nano"
  description = "The type of the instance"
}

variable "ami_id" {
  type        = string
  default     = "ami-0c7d68785ec07306c"
  description = "Amazon Linux 2 AMI in eu-north-1"
}

variable "security_group_name" {
  type        = string
  default     = "alex_sg_v5"
  description = "The name of the SG"
}

variable "instance_name" {
  type        = string
  default     = "alex_public_ec2_v5"
  description = "The name of the public instance"
}

variable "availability_zone" {
  type        = string
  default     = "eu-north-1a"
  description = "The availability zone to deploy resources on"
}

variable "private_subnet_name" {
  type        = string
  default     = "alex_private_subnet_v5"
  description = "The name of the private subnet"
}

variable "private_subnet_cidr" {
  type        = string
  default     = "10.0.2.0/24"
  description = "Private subnet CIDR block"
}

variable "private_instance_name" {
  type        = string
  default     = "alex_private_ec2_v5"
  description = "The name of the private instance"
}
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}









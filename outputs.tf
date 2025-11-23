output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.subnet.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = module.subnet.private_subnet_id
}

output "public_instance_id" {
  description = "ID of the public EC2 instance"
  value       = module.ec2.public_instance_id
}

output "public_instance_ip" {
  description = "Public IP of the public EC2 instance"
  value       = module.ec2.public_instance_ip
}

output "private_instance_id" {
  description = "ID of the private EC2 instance"
  value       = module.ec2.private_instance_id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = module.nat_gateway.nat_gateway_id
}
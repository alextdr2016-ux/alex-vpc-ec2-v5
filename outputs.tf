output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.alex_vpc_v5.id
}

output "subnet_id" {
  description = "The id of the public subnet"
  value       = aws_subnet.alex_public_subnet_v5.id
}

output "security_group_id" {
  description = "ID of the SG"
  value       = aws_security_group.alex_sg_v5.id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.alex_ec2_v5.id
}

output "instance_public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.alex_ec2_v5.public_ip
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.alex_private_subnet_v5.id
}

output "private_instance_id" {
  description = "ID of the private EC2 instance"
  value       = aws_instance.alex_private_ec2_v5.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.nat_gw_v5.id
}
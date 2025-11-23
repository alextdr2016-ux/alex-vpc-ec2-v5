output "sg_id" {
  value = aws_security_group.main.id
}

output "public_instance_id" {
  value = aws_instance.public.id
}

output "public_instance_ip" {
  value = aws_instance.public.public_ip
}

output "private_instance_id" {
  value = aws_instance.private.id
}
output "security_group_id" {
  description = "ID of the security group (alias for sg_id)"
  value       = aws_security_group.main.id
}
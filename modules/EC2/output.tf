output "ec2_instance_ids" {
  description = "List of EC2 instance IDs created in the public subnets"
  value       = aws_instance.ec2_instances[*].id
}

output "ec2_security_group_id" {
  description = "ID of the security group associated with the EC2 instances"
  value       = aws_security_group.ec2_sg.id
}
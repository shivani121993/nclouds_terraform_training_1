output "rds_instance_id" {
  description = "The ID of the created RDS instance"
  value       = aws_db_instance.rds_instance.id
}

output "rds_instance_endpoint" {
  description = "The endpoint (DNS address) of the RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_instance_port" {
  description = "The port on which the RDS instance listens"
  value       = aws_db_instance.rds_instance.port
}

output "rds_db_subnet_group_name" {
  description = "The name of the RDS DB subnet group"
  value       = aws_db_subnet_group.db_subnet_group.name
}

locals {
    owner   = "${var.identifier} - nclouds"
}
  
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "my-db-subnet-group-1"
  description = "My DB Subnet Group Description"

  subnet_ids     = var.private_subnet_ids


  tags = {
    Name  = "${var.identifier}-DB-Subnet-Group"
    Owner = local.owner
  }
}


resource "aws_db_instance" "rds_instance" {
  db_name             = "${var.identifier}-rds"
  allocated_storage   = var.allocated_storage
  storage_type        = var.storage_type
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  username            = var.rds_username
  password            = var.rds_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot = true


  tags = {
    Name  = "${var.identifier}-rds-instance"
    Owner = local.owner
  }
}

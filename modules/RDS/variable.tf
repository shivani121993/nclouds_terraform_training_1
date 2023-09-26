
variable "identifier" {
    type = string
    default = "shivani"
}

variable "rds_username" {
  description = "Username for the RDS instance"
  type        = string
}

variable "rds_password" {
  description = "Password for the RDS instance"
  type        = string
}

variable "allocated_storage" {
    type = number
    default = 20
}

variable "storage_type" {
    type = string
    default = "gp2"
}

variable "engine" {
    type = string
    default = "mysql"
}

variable "engine_version" {
  type = string
  default = "5.7"
}

variable "instance_class" {
  type = string
  default = "db.t3.small"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where the RDS instance will be created"
  type        = list(string)
}

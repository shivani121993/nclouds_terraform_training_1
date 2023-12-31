variable "identifier" {
    type = string
    default = "shivani"
  
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "vpc_id" {
  description = "VPC ID from module1"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs from module1"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs from module1"
  type        = list(string)
}






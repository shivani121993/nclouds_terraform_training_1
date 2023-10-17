variable "identifier" {
    type = string
    description = "This identifier will be placed in every resource Name"
}

variable "vpc_cidr" {
    type = string
    default = "19.0.0.0/16"
  
}

variable "total_subnets" {
    type = number
  
}

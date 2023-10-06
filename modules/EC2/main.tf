locals {
  owner         = "${var.identifier} - nclouds"
  allowed_ports = [22, 443, 80, 8080]
}

data "aws_ami" "myami_ss" {
  most_recent = true

  filter {
    name   = "name"
    values = ["myami-*"]  # Replace with the appropriate AMI name
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.identifier}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.allowed_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instances" {
  count         = length(var.public_subnet_ids)
  ami           = data.aws_ami.myami_ss.id
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_ids[count.index]

  security_groups = [aws_security_group.ec2_sg.id]

  tags = {
    Name  = "${var.identifier}-ec2-${count.index}"
    Owner = local.owner
  }
}

resource "aws_eip" "ec2_eip" {
  count    = length(aws_instance.ec2_instances)
  instance = aws_instance.ec2_instances[count.index].id
}


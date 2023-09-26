locals {
  owner   = "${var.identifier} - nclouds"
  subnets = var.total_subnets == 0 ? length(data.aws_availability_zones.available.names) : var.total_subnets
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name  = "${var.identifier}-vpc"
    owner = local.owner
  }
}

resource "aws_subnet" "public" {
  count = local.subnets
  vpc_id             = aws_vpc.vpc.id
  availability_zone  = element(data.aws_availability_zones.available.names, count.index)
  cidr_block         = cidrsubnet(var.vpc_cidr, 8, count.index)
  tags = {
    Name  = "${var.identifier}-public-${count.index}"
    Owner = local.owner
  }
}

resource "aws_subnet" "private" {
  count = local.subnets
  vpc_id             = aws_vpc.vpc.id
  availability_zone  = element(data.aws_availability_zones.available.names, count.index)
  cidr_block         = cidrsubnet(var.vpc_cidr, 8, count.index + local.subnets)
  tags = {
    Name  = "${var.identifier}-private-${count.index}"
    Owner = local.owner
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name  = "${var.identifier}-IGW"
    Owner = local.owner
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name  = "${var.identifier}-public-rt"
    Owner = local.owner
  }
}

resource "aws_route_table_association" "a1" {
  count          = local.subnets
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name  = "${var.identifier}-private-rt"
    Owner = local.owner
  }
}

resource "aws_route_table_association" "a2" {
  count          = local.subnets
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}


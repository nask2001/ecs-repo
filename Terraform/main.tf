data "aws_availability_zones" "azs" {}

resource "aws_vpc" "ecs_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = var.instance_tenancy

  tags = {
    "Name" = "ECS VPC"
  }
}

resource "aws_internet_gateway" "ecs_vpc_igw" {
  vpc_id = aws_vpc.ecs_vpc.id

  tags = {
    "Name" = "ECS VPC IGW"
  }
}

resource "aws_subnet" "public_subnet_one" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.public_subnet_one
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.azs.names[0]

  tags = {
    "Name" = "ECS Public Subnet One"
  }
}

resource "aws_subnet" "public_subnet_two" {
  vpc_id                  = aws_vpc.ecs_vpc.id
  cidr_block              = var.public_subnet_two
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.azs.names[1]

  tags = {
    "Name" = "ECS Public Subnet Two"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ecs_vpc.id

  route {
    cidr_block = var.default_gateway
    gateway_id = aws_internet_gateway.ecs_vpc_igw.id
  }

  tags = {
    "Name" = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_subnet_one_rta" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_one.id
}

resource "aws_route_table_association" "public_subnet_two_rta" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_two.id
}

resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.ecs_vpc.id

  tags = {
    "Name" = "Public Network ACL"
  }
}

resource "aws_network_acl_association" "public_subnet_one_acl_association" {
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = aws_subnet.public_subnet_one.id
}

resource "aws_network_acl_association" "public_subnet_two_acl_association" {
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = aws_subnet.public_subnet_two.id
}

resource "aws_network_acl_rule" "public_acl_rule_0" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = -1
  cidr_block     = var.default_gateway
  egress         = false
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "public_acl_rule_1" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number    = 100
  rule_action    = "allow"
  protocol       = -1
  cidr_block     = var.default_gateway
  egress         = true
  from_port      = 0
  to_port        = 0
}
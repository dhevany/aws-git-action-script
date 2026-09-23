# =========================================================
# VPC
# =========================================================

resource "aws_vpc" "customVPC" {

  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = var.vpc_name
    Environment = var.environment
  }
}


# =========================================================
# INTERNET GATEWAY
# =========================================================

resource "aws_internet_gateway" "customIGW" {

  vpc_id = aws_vpc.customVPC.id

  tags = {
    Name        = var.igw_name
    Environment = var.environment
  }
}


# =========================================================
# PUBLIC SUBNET 1
# Availability Zone 1
# =========================================================

resource "aws_subnet" "publicSubnet1" {

  vpc_id = aws_vpc.customVPC.id

  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.availability_zone_1

  map_public_ip_on_launch = true

  tags = {
    Name        = var.public_subnet_1_name
    Type        = "Public"
    Environment = var.environment
  }
}


# =========================================================
# PUBLIC SUBNET 2
# Availability Zone 2
# =========================================================

resource "aws_subnet" "publicSubnet2" {

  vpc_id = aws_vpc.customVPC.id

  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.availability_zone_2

  map_public_ip_on_launch = true

  tags = {
    Name        = var.public_subnet_2_name
    Type        = "Public"
    Environment = var.environment
  }
}


# =========================================================
# PRIVATE SUBNET 1
# Availability Zone 1
# =========================================================

resource "aws_subnet" "privateSubnet1" {

  vpc_id = aws_vpc.customVPC.id

  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  map_public_ip_on_launch = false

  tags = {
    Name        = var.private_subnet_1_name
    Type        = "Private"
    Environment = var.environment
  }
}


# =========================================================
# PRIVATE SUBNET 2
# Availability Zone 2
# =========================================================

resource "aws_subnet" "privateSubnet2" {

  vpc_id = aws_vpc.customVPC.id

  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  map_public_ip_on_launch = false

  tags = {
    Name        = var.private_subnet_2_name
    Type        = "Private"
    Environment = var.environment
  }
}


# =========================================================
# PUBLIC ROUTE TABLE
# =========================================================

resource "aws_route_table" "publicRT" {

  vpc_id = aws_vpc.customVPC.id

  tags = {
    Name        = var.public_route_table_name
    Environment = var.environment
  }
}


# =========================================================
# PUBLIC ROUTE
#
# 0.0.0.0/0 --> Internet Gateway
# =========================================================

resource "aws_route" "internetRoute" {

  route_table_id = aws_route_table.publicRT.id

  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.customIGW.id
}


# =========================================================
# ROUTE TABLE ASSOCIATION
#
# Public Subnet 1 --> Public Route Table
# =========================================================

resource "aws_route_table_association" "publicSubnet1Association" {

  subnet_id = aws_subnet.publicSubnet1.id

  route_table_id = aws_route_table.publicRT.id
}


# =========================================================
# ROUTE TABLE ASSOCIATION
#
# Public Subnet 2 --> Public Route Table
# =========================================================

resource "aws_route_table_association" "publicSubnet2Association" {

  subnet_id = aws_subnet.publicSubnet2.id

  route_table_id = aws_route_table.publicRT.id
}


# =========================================================
# ALB SECURITY GROUP
#
# Internet --> ALB
# Port 80
# Port 443
# =========================================================

resource "aws_security_group" "albSG" {

  name        = var.alb_sg_name

  description = "Allow HTTP and HTTPS inbound traffic to ALB"

  vpc_id = aws_vpc.customVPC.id


  # -------------------------------------------------------
  # HTTP
  # -------------------------------------------------------

  ingress {

    description = "Allow HTTP from Internet"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }


  # -------------------------------------------------------
  # HTTPS
  # -------------------------------------------------------

  ingress {

    description = "Allow HTTPS from Internet"

    from_port = 443

    to_port = 443

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }


  # -------------------------------------------------------
  # Outbound
  # -------------------------------------------------------

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }


  tags = {

    Name = var.alb_sg_name

    Environment = var.environment
  }
}


# =========================================================
# EC2 SECURITY GROUP
#
# Only allow HTTP traffic coming from the ALB SG
# =========================================================

resource "aws_security_group" "ec2SG" {

  name = var.ec2_sg_name

  description = "Allow application traffic from ALB"

  vpc_id = aws_vpc.customVPC.id


  # -------------------------------------------------------
  # HTTP from ALB
  # -------------------------------------------------------

  ingress {

    description = "Allow HTTP traffic from ALB"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    security_groups = [
      aws_security_group.albSG.id
    ]
  }


  # -------------------------------------------------------
  # Outbound
  # -------------------------------------------------------

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }


  tags = {

    Name = var.ec2_sg_name

    Environment = var.environment
  }
}

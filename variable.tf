# =====================================================
# AWS REGION
# =====================================================

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ca-central-1"
}


# =====================================================
# VPC
# =====================================================

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.80.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "Custom-VPC"
}


# =====================================================
# AVAILABILITY ZONES
# =====================================================

variable "availability_zone_1" {
  description = "First Availability Zone"
  type        = string
  default     = "ca-central-1a"
}

variable "availability_zone_2" {
  description = "Second Availability Zone"
  type        = string
  default     = "ca-central-1b"
}


# =====================================================
# PUBLIC SUBNET 1
# =====================================================

variable "public_subnet_1_cidr" {
  description = "CIDR for Public Subnet 1"
  type        = string
  default     = "10.80.1.0/24"
}

variable "public_subnet_1_name" {
  description = "Name for Public Subnet 1"
  type        = string
  default     = "Public-Subnet-1"
}


# =====================================================
# PUBLIC SUBNET 2
# =====================================================

variable "public_subnet_2_cidr" {
  description = "CIDR for Public Subnet 2"
  type        = string
  default     = "10.80.2.0/24"
}

variable "public_subnet_2_name" {
  description = "Name for Public Subnet 2"
  type        = string
  default     = "Public-Subnet-2"
}


# =====================================================
# PRIVATE SUBNET 1
# =====================================================

variable "private_subnet_1_cidr" {
  description = "CIDR for Private Subnet 1"
  type        = string
  default     = "10.80.11.0/24"
}

variable "private_subnet_1_name" {
  description = "Name for Private Subnet 1"
  type        = string
  default     = "Private-Subnet-1"
}


# =====================================================
# PRIVATE SUBNET 2
# =====================================================

variable "private_subnet_2_cidr" {
  description = "CIDR for Private Subnet 2"
  type        = string
  default     = "10.80.12.0/24"
}

variable "private_subnet_2_name" {
  description = "Name for Private Subnet 2"
  type        = string
  default     = "Private-Subnet-2"
}


# =====================================================
# INTERNET GATEWAY
# =====================================================

variable "igw_name" {
  description = "Internet Gateway Name"
  type        = string
  default     = "Custom-IGW"
}


# =====================================================
# ROUTE TABLE
# =====================================================

variable "public_route_table_name" {
  description = "Public Route Table Name"
  type        = string
  default     = "Public-Route-Table"
}


# =====================================================
# ALB SECURITY GROUP
# =====================================================

variable "alb_sg_name" {
  description = "Security Group name for Application Load Balancer"
  type        = string
  default     = "ALB-SG"
}


# =====================================================
# EC2 SECURITY GROUP
# =====================================================

variable "ec2_sg_name" {
  description = "Security Group name for EC2 instances"
  type        = string
  default     = "EC2-SG"
}


# =====================================================
# COMMON TAG
# =====================================================

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "Development"
}

# =========================================================
# EC2 VARIABLES
# =========================================================

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-xxxxxxxxxxxxxxxxx"
}

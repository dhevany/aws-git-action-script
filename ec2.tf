
 =========================================================
# EC2 INSTANCE 1
# Public Subnet 1 - Availability Zone 1
# =========================================================

resource "aws_instance" "appServer1" {

  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id = aws_subnet.publicSubnet1.id

  vpc_security_group_ids = [
    aws_security_group.ec2SG.id
  ]

  user_data = file("user-data.sh")

  tags = {
    Name        = "App-Server-01"
    Environment = var.environment
  }
}


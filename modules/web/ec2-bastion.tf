# Bastion Host EC2 Instance
resource "aws_instance" "bastion" {
  depends_on = [aws_key_pair.key_pair]
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type
  subnet_id = var.public_subnet_ids[0]
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2-bastion-sg.id]

  tags = {
      Name = "${var.environment}-Bastion-Host"
      Environment = var.environment
    }
}

# Bastion EC2 Security Group (SSH -> EC2)
resource "aws_security_group" "ec2-bastion-sg" {
  name = "${var.environment}-ec2-bastion-sg"
  description = "Allows SSH traffic to Web EC2 only"
  vpc_id = var.vpc_id
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create & Assign EIP to Bastion Host
resource "aws_eip" "bastion_ip" {
  depends_on = [aws_instance.bastion]
  instance = aws_instance.bastion.id
  vpc = true
}

# Private Key Creation
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

# Store Private Key locally for SSH
resource "local_file" "private_key" {
  content = tls_private_key.rsa.private_key_pem
  filename = "private-keys/${var.key_name}-private"
  file_permission = "400"
}

# AWS Key Pair for EC2
resource "aws_key_pair" "key_pair" {
  key_name = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh
}
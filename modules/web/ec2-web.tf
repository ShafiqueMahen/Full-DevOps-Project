# Nginx Web EC2 Instance
resource "aws_instance" "web" {
  depends_on = [aws_key_pair.key_pair]
  count = length(var.private_subnet_ids)
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_ids[count.index]
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2-web-sg.id]
  

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo amazon-linux-extras install -y nginx1
    sudo echo "Terraform Nginx Website" > /usr/share/nginx/html/index.html
    sudo curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | sudo tee -a /usr/share/nginx/html/index.html >/dev/null
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF

  tags = {
      Name = "${var.environment}-Nginx-Instance-#${count.index}"
      Environment = var.environment
    }
}

# Web EC2 Security Group (ALB, SSH (Bastion) -> EC2)
resource "aws_security_group" "ec2-web-sg" {
  depends_on = [aws_security_group.alb-sg, aws_security_group.ec2-bastion-sg]
  name = "${var.environment}-ec2-web-sg"
  description = "Allows ALB and SSH from bastion host only"
  vpc_id = var.vpc_id
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.alb-sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2-bastion-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Amazon Linux 2 AMI Data used
data "aws_ami" "amazon-linux-2" {
    most_recent = true
    
    filter {
      name   = "owner-alias"
      values = ["amazon"]
    }

    filter {
      name   = "name"
      values = ["amzn2-ami-hvm*"]
    }

    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }
}



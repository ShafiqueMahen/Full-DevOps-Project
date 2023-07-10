# ALB to direct traffic
resource "aws_lb" "alb" {
  name = "${var.environment}-ALB"
  internal = false
  load_balancer_type = "application"
  subnets = var.public_subnet_ids
  security_groups = [aws_security_group.alb-sg.id]
}

# ALB Security Group (Internet -> ALB)
resource "aws_security_group" "alb-sg" {
  name = "${var.environment}-alb-sg"
  description = "Allows for Internet Traffic to reach ALB"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
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

# ALB Target Group
resource "aws_alb_target_group" "ec2-target-group" {
    name = "${var.environment}-alb-ec2-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "instance"

    health_check {
        enabled = true
        path = "/"
        port = "traffic-port"
        healthy_threshold = 3
        unhealthy_threshold = 3
        timeout = 5
        interval = 60
        matcher = "200-399"
    }
}
# ALB Target Group Attachment (to EC2)
resource "aws_alb_target_group_attachment" "target_group_attachment" {
    count = length(var.private_subnet_ids)
    target_group_arn = aws_alb_target_group.ec2-target-group.arn
    target_id = aws_instance.web[count.index].id
}


# ALB Listener
resource "aws_alb_listener" "ec2-alb-http-listener" {
    load_balancer_arn = aws_lb.alb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.ec2-target-group.arn
    }
}


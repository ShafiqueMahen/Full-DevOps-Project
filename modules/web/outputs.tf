output "alb_sg_id" {
  description = "The ID of the ALB SG"
  value = aws_security_group.alb-sg.id
}

output "ec2_bastion_sg_id" {
  description = "The ID of the Bastion EC2 SG"
  value = aws_security_group.ec2-bastion-sg.id
}

output "ec2_web_sg_id" {
  description = "The ID of the web EC2 SG"
  value = aws_security_group.ec2-web-sg.id
}

output "ec2_bastion_public_ip" {
    description = "The Elastic IP assigned to the bastion EC2 instance"
    value = aws_eip.bastion_ip.public_ip
}

output "ec2_bastion_private_ip" {
    description = "The Private IP of the bastion EC2 instance"
    value = aws_instance.bastion.private_ip
}

output "ec2_web_private_ip" {
    description = "The Private IP of the web EC2 instances"
    value = aws_instance.web[*].private_ip
}

output "alb_dns" {
    description = "The DNS name for the ALB"
    value = aws_lb.alb.dns_name
}
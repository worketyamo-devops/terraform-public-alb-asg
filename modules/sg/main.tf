############ creation des security groups de l'ALB #########
resource "aws_security_group" "public-alb-sg" {
  name = "public-alb-tf"
}

resource "aws_vpc_security_group_ingress_rule" "allow-http-alb" {
  security_group_id = aws_security_group.public-alb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = "80"
  to_port           = "80"
}

resource "aws_vpc_security_group_egress_rule" "allow-http-alb" {
  security_group_id = aws_security_group.public-alb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}


############ Security  group de l'ASG ########
resource "aws_security_group" "private-asg-sg" {
  name = "private-asg-sg"
}

resource "aws_vpc_security_group_ingress_rule" "allow-http-priv-asg" {
  security_group_id            = aws_security_group.private-asg-sg.id
  referenced_security_group_id = aws_security_group.public-alb-sg.id
  ip_protocol                  = "tcp"
  from_port                    = "80"
  to_port                      = "80"
}

resource "aws_vpc_security_group_egress_rule" "allow-http-asg" {
  security_group_id = aws_security_group.private-asg-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
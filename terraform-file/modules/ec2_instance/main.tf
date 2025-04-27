resource "aws_security_group" "instance_sg" {
  name = "${var.instance_name}-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.security_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  associate_public_ip_address = true

  user_data = var.install_script

  tags = {
    Name = var.instance_name
  }
}

output "public_ip" {
  value = aws_instance.instance.public_ip
}

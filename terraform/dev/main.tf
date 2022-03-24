
resource "aws_key_pair" "ssh_key" {
  key_name   = "${var.env}_duck_conf_key"
  public_key = file(var.ssh_key)

  tags = {
    Name = "${var.env}-duck-conf"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-072ec828dae86abe5" # Centos 7 eu-west-3
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name

  vpc_security_group_ids = [aws_security_group.web_access.id]
  user_data              = templatefile("script/setup_vm.sh", {env: var.env})

  tags = {
    Name = "${var.env}-duck-conf"
  }
}

resource "aws_security_group" "web_access" {
  name = "sg_http_protocol_${var.env}"

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0",]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.env}-duck-conf"
  }
}
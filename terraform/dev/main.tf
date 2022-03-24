
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
  user_data              = <<EOF
#! /bin/bash
sudo yum update
echo "SELINUX=permissive" | sudo tee /etc/selinux/config
sudo setenforce 0

# clone repo
sudo yum install -y git
git clone https://github.com/BenJoyenConseil/kata-iac.git
cd kata-iac
sudo git checkout master

# configure backend
sudo yum install -y httpd apr apr-util-sqlite
sudo mv apache/dev/httpd.conf /etc/httpd/conf/httpd.conf

sudo systemctl start httpd
sudo systemctl enable httpd

EOF

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
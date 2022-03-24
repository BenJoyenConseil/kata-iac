data "aws_security_group" "sg_io" {

  name = var.sg_name
}

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

  vpc_security_group_ids = [data.aws_security_group.sg_io.id]
  user_data              = templatefile("script/setup_vm.sh", {apache_conf: var.apache_config_gitpath})

  tags = {
    Name = "${var.env}-duck-conf"
  }
}
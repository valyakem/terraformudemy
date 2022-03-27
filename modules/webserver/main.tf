terraform {
  required_version = ">= 0.12"
}

resource "aws_subnet" "webserver" {
  vpc_id = aws_vpc.vpc.main.id
  cidr_block = aws_vpc.main.cidr_block
}

resource "aws_instance" "webserver" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.webserver.id

  tags = {
    "Name" = "${var.webserver_name}-Webserver"
  }
}
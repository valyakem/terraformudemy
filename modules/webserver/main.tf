
resource "aws_instance" "webserver" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    "Name" = "${var.webserver_name}-Webserver"
  }
}
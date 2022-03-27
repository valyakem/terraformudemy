locals {
  azs_names        = "${data.aws_availability_zones.azs.names[0]}"
} 

//Create your public subnet
resource "aws_subnet" "nb_publicsubnet" {
  count             = "${length(local.azs_names)}"
  vpc_id            = aws_vpc.nbvpc.id
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, 1)}"
  availability_zone = "${local.azs_names[count.index]}"

  tags = {
    Name = "NB-PublicSubnet-${count.index}"
  }
}
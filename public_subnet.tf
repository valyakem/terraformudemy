locals {
  azs_names        = "${data.aws_availability_zones.azs.names[0]}"
} 

resource "aws_subnet" "nb_publicsubnet" {
  count             = "${length(local.azs_names[0])}"
  vpc_id            = aws_vpc.nbvpc.id
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, 1)}"
  availability_zone = "${local.az_names[count.index]}"

  tags = {
    Name = "NB-PublicSubnet-${count.index}"
  }
}
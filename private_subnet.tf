//Create your private subnet. let us set only two private subnets.
resource "aws_subnet" "nb_privatesubnet" {
  count             = "${length(slice(local.azs_names, 0, 2))}" //note, the last index is not counted. 
  vpc_id            = "${aws_vpc.nbvpc.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
  availability_zone = "${local.azs_names[count.index]}"

  tags = {
    Name = "NB-PrivateSubnet-${count.index + 1}"
  }
}
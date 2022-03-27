terraform {
  required_version = ">= 0.12"
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.nbvpc.id
  cidr_block = aws_vpc.nbvpc.cidr_block
}


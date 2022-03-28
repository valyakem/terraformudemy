
//Create your public subnet
resource "aws_subnet" "nb_publicsubnet" {
  count                   = "${length(local.azs_names)}"
  vpc_id                  = "${aws_vpc.nbvpc.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, count.index)}" 
  availability_zone       = "${local.azs_names[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "NB-PublicSubnet-${count.index + 1}"
  }
}


//create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.nbvpc.id}"

  tags = {
    Name = "NB-IGW"
  }
}

//Internet route table
resource "aws_route_table" "pubrt" {
  vpc_id = "${aws_vpc.nbvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  # route {
  #   ipv6_cidr_block        = "::/0"
  #   egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  # }
  tags = {
    Name = "nb-rt"
  }
}


//create a network association to associate the route table with the public subnet from all regions
resource "aws_route_table_association" "pubsubassoc" {
  count           = "${length(local.azs_names)}"
  subnet_id       = "${local.pubsubid[count.index]}" //returns list of subnet ids using count.index
  route_table_id  = "${aws_route_table.pubrt.id}"
}
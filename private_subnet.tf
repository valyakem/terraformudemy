//Create your private subnet. let us set only two private subnets.
resource "aws_subnet" "nb_privatesubnet" {
  count             = "${length(slice(local.azs_names, 0, 2))}" //note, the last index is not counted. 
  vpc_id            = "${aws_vpc.nbvpc.id}"
  cidr_block        = "${cidrsubnet(var.vpc_cidr, 8, count.index  + length(local.azs_names))}"
   //note + length is to have the numbering start from the last cidr
  availability_zone = "${local.azs_names[count.index]}"

  tags = {
    Name = "NB-PrivateSubnet-${count.index + 1}"
  }
}


//NAT instance to translate ip addresses
resource "aws_instance" "natinst" {
  ami                           = "${var.natamis[var.region]}"
  instance_type                 = "t2.micro"
  subnet_id                     = "${local.pubsubid[0]}"
  source_dest_check             = false
  security_group_id             = "${aws_security_group.nat_sg.id}"
  //associate_public_ip_address   = true

  tags = {
    "Name" = "nbnat"
  }
}


//Internet route table
resource "aws_route_table" "privrt" {
  vpc_id = "${aws_vpc.nbvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.natinst.id}"
  }

  tags = {
    Name = "nb-rt"
  }
}


//create a subnet association for the private route table
resource "aws_route_table_association" "priv_rt_assoc" {
  count                         = "${length(slice(local.azs_names, 0, 2))}" 
  subnet_id                     = "${local.privsubid[count.index]}" 
  route_table_id                = "${aws_route_table.privrt.id}" 
}

//NAT Instance Security Group
resource "aws_security_group" "nat_sg" {
  name                          = "NAT SG"
  description                   = "Allow traffic for private subnets"
  vpc_id                        = "${aws_vpc.nbvpc.id}"

  egress {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      cidr_blocks =  ["0.0.0.0/0"]
      prefix_list_ids = ["pl-12c4e678"]
  }
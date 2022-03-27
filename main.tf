locals {
    az_names           = "${data.aws_availability_zones.azs.names}"
}

resource "aws_vpc" "nbvpc" {
    cidr_block          = "10.0.0.0/16"
    instance_tenancy    = "default"

    tags = {
        Name            = "nb_vpc"
        Environment     = "Testing"
    }
}

module "pub_subnets" {
source                  = "./modules/public_subnet"
vpc_id                  = "${aws_vpc.nbvpc.id}"
cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
aws_availability_zone   = "${local.az_names[count.index]}"

tags = {
    Name    = "PublicSubnet-${count.index + 1}"
}
}

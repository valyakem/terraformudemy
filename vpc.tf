resource "aws_vpc" "nbvpc" {
    cidr_block          = "${var.vpc_cidr}"
    instance_tenancy    = "default"

    tags = {
        Name            = "nb_vpc"
        Environment     = "Testing"
    }
}
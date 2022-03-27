provider "aws" {
    region  = "us-east-1"
}

resource "aws_vpc" "main" {
    cidr_block "10.0.0.0/16"
}

module "nb_webserver" {
    source              = "./modules/webserver"
    
    vpc_id              = aws_vpc.main.id
    cidr_block          = "10.0.0.0/16"
    webserver_name      = "nb_webserver"
    ami                 = "ami-04505e74c0741db8d"

}
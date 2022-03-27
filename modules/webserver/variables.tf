variable "vpc_id" {
  type              = string
  description       = "VPC ID"
}

variable "cidr_block" {
   type                 = string
  description           = "subnet cidr block"
}

variable "webserver_name" {
   type                 = string
  description           = "Name of webserver to provision"
}

variable "ami" {
   type                 = string
  description           = "Name of ami for your webserver to provision"
}

variable "instance_type" {
   type                 = string
  description           = "Select your instance type e.g. 't2.micro', t2.medium', etc.,"
  default               = "t2.micro"
}

variable "vpc_cidr" {
  description                   = "Choose a vpc cidr block for your application or implementation"
  type                          = string
  default                       = "10.0.0.0/16" 
}

variable "region" {
  description                   = "provide the default region to provision your resources"
  type                          = string
  default                       = "us-east-1" 
}


variable "natamis" {
  type   = "map"
  default = {
      us-east-1 = "ami-04505e74c0741db8d"
      us-east-2 = "ami-0fb653ca2d3203ac1"
  }
}
# variable "azs" {
#   description                   = "enter the availability zones"
#   type                          = list(string) 
#   default = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
# }       
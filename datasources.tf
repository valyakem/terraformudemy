//Declare your datasources here
data "aws_availability_zones" "azs" {
  state = "available"
}
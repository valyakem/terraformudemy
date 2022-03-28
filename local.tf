locals {
  azs_names        = "${data.aws_availability_zones.azs.names}"
  pubsubid         = "${aws_subnet.nb_publicsubnet.*.id}"
  privsubid        = "${aws_subnet.nb_privatesubnet.*.id}"
} 
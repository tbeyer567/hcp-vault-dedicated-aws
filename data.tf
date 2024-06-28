data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_ec2_transit_gateway" "tgw" {
  id = var.tgw_id
}
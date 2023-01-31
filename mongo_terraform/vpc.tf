# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "3.11.5"

#   name = var.project_name
#   cidr = "10.0.0.0/16"
#   azs  = data.aws_availability_zones.zones.names
#   public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

#   tags = {
#     Name = var.project_name
#   }
# }

# resource "aws_vpc" "vpc" {
# cidr_block = "${var.vpc-cidr}"
# instance_tenancy        = "default"
# enable_dns_hostnames    = true
# tags      = {
# Name    = "Test_VPC"
# }
# }
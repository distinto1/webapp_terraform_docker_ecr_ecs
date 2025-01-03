locals {
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 3, k + 4)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 3, k)]
  azs             = slice(data.aws_availability_zones.available_zones.names, 0, 4)
}
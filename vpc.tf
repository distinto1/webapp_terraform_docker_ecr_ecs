# create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "eligant_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create public subnet az1
resource "aws_subnet" "pub_eligant_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_eligant_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public_AZ1"
  }
}

# create public subnet az2
resource "aws_subnet" "pub_eligant_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub_eligant_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public_AZ2"
  }
}

# create route table and add public route
resource "aws_route_table" "eligant_public-RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eligant_igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-eligant_public-RT"
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "pub_subnet_az1_rt_association" {
  subnet_id      = aws_subnet.pub_eligant_subnet_az1.id
  route_table_id = aws_route_table.eligant_public-RT.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_2_rt_association" {
  subnet_id      = aws_subnet.pub_eligant_subnet_az2.id
  route_table_id = aws_route_table.eligant_public-RT.id
}

# create private app subnet az1
resource "aws_subnet" "private_eligantapp_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_eligantapp_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-eligantapp_subnet_az1"
  }
}

# create private app subnet az2
resource "aws_subnet" "private_eligantapp_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_eligantapp_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private_eligantapp_subnet_az2"
  }
}

# create private data subnet az1
resource "aws_subnet" "private_eligantdata_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_eligantdata_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private_eligantdata_subnet_az1"
  }
}

# create private data subnet az2
resource "aws_subnet" "private_eligantdata_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_eligantdata_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-eligantdata_subnet_az2"
  }
}
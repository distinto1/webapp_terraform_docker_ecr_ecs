# allocate elastic ips. used by nat-gateway, 1 in each az in the public subnets
resource "aws_eip" "eip" {
  count = 2
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-${var.environment}-eip-${count.index + 1}"
  }
}

# create nat gateway in public subnet az1 & az2
resource "aws_nat_gateway" "ng_az1" {
  allocation_id = aws_eip.eip[0].id
  subnet_id     = aws_subnet.pub_eligant_subnet_az1.id

  tags = {
    Name = "${var.project_name}-${var.environment}-ng_az1"
  }
    # to ensure proper ordering, it is recommended to add an explicit dependency
    # on the internet gateway for the vpc
  depends_on = [aws_internet_gateway.eligant_igw]
}

resource "aws_nat_gateway" "ng_az2" {
  allocation_id = aws_eip.eip[1].id
  subnet_id     = aws_subnet.pub_eligant_subnet_az2.id

  tags = {
    Name = "${var.project_name}-${var.environment}-ng_az2"
  }
    # to ensure proper ordering, it is recommended to add an explicit dependency
    # on the internet gateway for the vpc
  depends_on = [aws_internet_gateway.eligant_igw]
}

# create private route table az1 & az2 and add route through nat gateway az1
resource "aws_route_table" "private_routetable_az1" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng_az1.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private_routetable_az1"
  }
}

resource "aws_route_table" "private_routetable_az2" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng_az2.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private_routetable_az2"
  }
}

# associate private app subnet az1 with private route table az1
resource "aws_route_table_association" "private_app_subnet_az1_rt_az1_association" {
  subnet_id      = aws_subnet.private_eligantapp_subnet_az1.id
  route_table_id = aws_route_table.private_routetable_az1.id
}

# associate private app subnet az2 with private route table az2
resource "aws_route_table_association" "private_data_subnet_az1_rt_az1_association" {
  subnet_id      = aws_subnet.private_eligantapp_subnet_az2.id
  route_table_id = aws_route_table.private_routetable_az2.id
}

# associate private data subnet az1 with private route table az1
resource "aws_route_table_association" "private_app_subnet_az2_rt_az2_association" {
  subnet_id      = aws_subnet.private_eligantdata_subnet_az1.id
  route_table_id = aws_route_table.private_routetable_az1.id
}

# associate private data subnet az2 with private route table az2
resource "aws_route_table_association" "private_data_subnet_az2_rt_az2_association" {
  subnet_id      = aws_subnet.private_eligantdata_subnet_az2.id
  route_table_id = aws_route_table.private_routetable_az2.id
}
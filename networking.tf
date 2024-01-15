resource "aws_vpc" "first_vpc" {
  cidr_block           = "10.0.0.0/24"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "First_VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.first_vpc.id
  cidr_block = "10.0.0.0/25"
  tags = {
    Name = "Public_subnet_first_VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.first_vpc.id
  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.first_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block         = "20.0.0.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.tg.id
  }
  tags = {
    Name = "PublicRT"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet.id
}

### Second infrastructure
resource "aws_vpc" "second_vpc" {
  cidr_block           = "20.0.0.0/24"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "Second_VPC"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.second_vpc.id
  cidr_block = "20.0.0.0/25"
  tags = {
    Name = "Private_subnet_second_VPC"
  }
}

resource "aws_default_route_table" "private_rt" {
  default_route_table_id = aws_vpc.second_vpc.default_route_table_id
  route {
    cidr_block         = "10.0.0.0/24"
    transit_gateway_id = aws_ec2_transit_gateway.tg.id
  }
  tags = {
    Name = "Private_route_table_second_VPC"
  }
}

### Transit Gateway
resource "aws_ec2_transit_gateway" "tg" {
  description = "TG for peering two VPCs"
  tags = {
    Name = "DemoTG"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tg_attachment1" {
  subnet_ids         = [aws_subnet.public_subnet.id]
  vpc_id             = aws_vpc.first_vpc.id
  transit_gateway_id = aws_ec2_transit_gateway.tg.id
  tags = {
    Name = "First_VPC_TGA"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tg_attachment2" {
  subnet_ids         = [aws_subnet.private_subnet.id]
  vpc_id             = aws_vpc.second_vpc.id
  transit_gateway_id = aws_ec2_transit_gateway.tg.id
  tags = {
    Name = "Second_VPC_TGA"
  }
}

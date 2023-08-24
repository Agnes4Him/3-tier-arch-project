# creating vpc
resource aws_vpc "demo_vpc"{
  cidr_block = var.vpc_cidr

  tags = {
    Name = "demo_vpc"
  }
}
# creating web-tier subnet A
resource "aws_subnet" "web_subnetA" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = var.web_subnetA
  availability_zone = var.az_1

  tags = {
    Name = "web_subnetA"
  }
}

# creating web-tier subnet B
resource "aws_subnet" "web_subnetB" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = var.web_subnetB
  availability_zone = var.az_2

  tags = {
    Name = "web_subnetB"
  }
}

# creating app-tier subnet A
resource aws_subnet "app_subnetA"{
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = var.app_subnetA
  availability_zone = var.az_1

  tags = {
    Name = "app_subnetA"
  }
}
# creating app-tier subnet B
resource aws_subnet "app_subnetB"{
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = var.app_subnetB
  availability_zone = var.az_2

  tags = {
    Name = "app_subnetB"
  }
}

# creating db-tier subnet A
resource aws_subnet "db_subnetA"{
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = var.db_subnetA
  availability_zone = var.az_1
  tags = {
    Name = "db_subnetA"
  }
}

# creating db-tier subnet B
resource aws_subnet "db_subnetB"{
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = var.db_subnetB
  availability_zone = var.az_2
  tags = {
    Name = "db_subnetB"
  }
}

# creating an internet gateway
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo_igw"
  }
}

# creating a public route table for resources in web-tier
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "public_rtb"
  }
}

# creating a route for resources in the web-tier
resource "aws_route" "public_rt" {
  route_table_id = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.demo_igw.id

}

# associating the route table to web subnet A
resource "aws_route_table_association" "public_rtb_assoc1" {
  subnet_id = aws_subnet.web_subnetA.id
  route_table_id = aws_route_table.public_rtb.id
}

# associating the route table to web subnet B
resource "aws_route_table_association" "public_rtb_assoc2" {
  subnet_id = aws_subnet.web_subnetA.id
  route_table_id = aws_route_table.public_rtb.id
}
# creating an elastic IP for a NAT gateway
resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.public_rtb_assoc1
  ]
  vpc = true
}
# Creating a NAT gateway in public subnet 1
resource "aws_nat_gateway" "cloudNAT" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  
  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.web_subnetA.id
  tags = {
    Name = "NAT gateway 1"
  }
}

# Creating a Route Table for the Nat Gateway 
resource "aws_route_table" "private_rtb" {
  depends_on = [
    aws_nat_gateway.cloudNAT
  ]

  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.cloudNAT.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}


# Associating route table for NAT gateway to public subnet A
resource "aws_route_table_association" "private_rtb_assoc1" {
  depends_on = [
    aws_route_table.private_rtb
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.app_subnetA.id

# Route Table ID
  route_table_id = aws_route_table.private_rtb.id
}

# Associating route table for NAT gateway to public subnet B
resource "aws_route_table_association" "private_rtb_assoc2" {
  depends_on = [
    aws_route_table.private_rtb
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.app_subnetB.id

# Route Table ID
  route_table_id = aws_route_table.private_rtb.id
}

# Associating route table for NAT gateway to public subnet B
resource "aws_route_table_association" "private_rtb_assoc3" {
  depends_on = [
    aws_route_table.private_rtb
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.db_subnetA.id

# Route Table ID
  route_table_id = aws_route_table.private_rtb.id
}

# Associating route table for NAT gateway to public subnet B
resource "aws_route_table_association" "private_rtb_assoc4" {
  depends_on = [
    aws_route_table.private_rtb
  ]

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = aws_subnet.db_subnetB.id

# Route Table ID
  route_table_id = aws_route_table.private_rtb.id
}
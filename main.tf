/*==== The VPC ======*/
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/1"

  tags = {
    Name  = var.iac_cdc_lyit
    Owner = var.owner_name
    proj  = var.proj_name
  }
}

/*==== SUBNETS PUBLIC ======*/
resource "aws_subnet" "pub_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name  = var.pub_cdc_lyit
    Owner = var.owner_name
    proj  = var.proj_name
  }
}

/*==== SUBNETS PRIVATE ======*/
resource "aws_subnet" "prv_subnet_dbase" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name  = var.priv_cdc_lyit
    Owner = var.owner_name
    proj  = var.proj_name
  }
}

resource "aws_subnet" "prv_subnet_mgmt" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name  = var.priv_cdc_lyit
    Owner = var.owner_name
    proj  = var.proj_name
  }
}

/* INET GATEWAY */
resource "aws_internet_gateway" "inet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name  = var.iac_cdc_lyit
    Owner = var.owner_name
    proj  = var.proj_name
  }
}

/* PUBLIC ROUTING TABLE */
resource "aws_route_table" "public_routing_table" {
  vpc_id = aws_vpc.main.id

  route { #traffic from anywhere is routed
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inet_gateway.id
  }

  tags = {
    Name  = var.iac_cdc_lyit
    Owner = var.owner_name
    proj  = var.proj_name
  }
}

/* NAT GATEWAY */
resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.public_routing_table.id
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_elastic_ip" {
  vpc = true
  tags = {
    Name  = var.iac_cdc_lyit
    Owner = var.owner_name
    proj  = var.proj_name
  }
}

/* NAT GATEWAY */
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_elastic_ip.id
  subnet_id     = aws_subnet.pub_subnet.id
  tags = {
    Name  = var.iac_cdc_lyit
    Owner = var.owner_name
    proj  = var.proj_name
  }
}

/* PRIVATE ROUTING TABLE */
resource "aws_route_table" "private_routing_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name  = var.iac_cdc_lyit
    Owner = var.owner_name
    proj  = var.proj_name
  }
}

resource "aws_route_table_association" "private_mgnt_routing_table_assoc" {
  subnet_id      = aws_subnet.prv_subnet_mgmt.id
  route_table_id = aws_route_table.private_routing_table.id
}

resource "aws_route_table_association" "private_dbase_routing_table_assoc" {
  subnet_id      = aws_subnet.prv_subnet_dbase.id
  route_table_id = aws_route_table.private_routing_table.id
}
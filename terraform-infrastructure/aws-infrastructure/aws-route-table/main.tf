resource "aws_route_table" "main" {
  vpc_id = var.eks_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "${var.environment}-route-table"
  }
}

resource "aws_route_table_association" "primary" {
  subnet_id      = var.eks_primary_subnet_id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "secondary" {
  subnet_id      = var.eks_secondary_subnet_id
  route_table_id = aws_route_table.main.id
}
resource "aws_internet_gateway" "main" {
  vpc_id = var.eks_vpc_id

  tags = {
    Name = "${var.environment}-internet-gateway"
  }
}
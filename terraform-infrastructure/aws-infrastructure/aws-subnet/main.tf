# Primary Subnet for EKS
resource "aws_subnet" "eks_primary" {
  vpc_id                  = var.eks_vpc_id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-eks-primary-subnet"
  }
}

# Secondary Subnet for EKS
resource "aws_subnet" "eks_secondary" {
  vpc_id                  = var.eks_vpc_id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-eks-secondary-subnet"
  }
}

# Primary Subnet for RDS
resource "aws_subnet" "rds_primary" {
  vpc_id            = var.rds_vpc_id
  cidr_block        = "172.31.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "${var.environment}-rds-primary-subnet"
  }

}

# Secondary Subnet for RDS
resource "aws_subnet" "rds_secondary" {
  vpc_id            = var.rds_vpc_id
  cidr_block        = "172.31.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "${var.environment}-rds-secondary-subnet"
  }

}

# Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.rds_primary.id, aws_subnet.rds_secondary.id]
}
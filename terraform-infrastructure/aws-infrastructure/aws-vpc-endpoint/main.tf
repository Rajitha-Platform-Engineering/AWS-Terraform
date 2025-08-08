# VPC Endpoint for ECR API in the EKS VPC
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id             = var.eks_vpc_id
  service_name       = "com.amazonaws.eu-central-1.ecr.api"
  subnet_ids         = [var.eks_primary_subnet_id, var.eks_secondary_subnet_id]
  security_group_ids = [var.eks_security_group_id]
  vpc_endpoint_type  = "Interface"

  private_dns_enabled = true


  tags = {
    environment = var.environment
    Name        = "${var.environment}-vpc-endpoint-api"
  }

}

# VPC Endpoint for ECR DKR API in the EKS VPC
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id             = var.eks_vpc_id
  service_name       = "com.amazonaws.eu-central-1.ecr.dkr"
  subnet_ids         = [var.eks_primary_subnet_id, var.eks_secondary_subnet_id]
  security_group_ids = [var.eks_security_group_id]
  vpc_endpoint_type  = "Interface"

  private_dns_enabled = true

  tags = {
    environment = var.environment
    Name        = "${var.environment}-vpc-endpoint-dkr"
  }

}

# VPC Endpoint for ECR S3 API in the EKS VPC
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.eks_vpc_id
  service_name      = "com.amazonaws.eu-central-1.s3"
  vpc_endpoint_type = "Gateway"

  tags = {
    environment = var.environment
    Name        = "${var.environment}-vpc-endpoint-s3"
  }

}

# VPC Endpoint for RDS in the EKS VPC
resource "aws_vpc_endpoint" "rds" {
  vpc_id             = var.eks_vpc_id
  service_name       = "com.amazonaws.eu-central-1.rds"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [var.eks_primary_subnet_id, var.eks_secondary_subnet_id]
  security_group_ids = [var.eks_security_group_id]

  private_dns_enabled = true

  tags = {
    environment = var.environment
    Name        = "${var.environment}-vpc-endpoint-rds"
  }

}
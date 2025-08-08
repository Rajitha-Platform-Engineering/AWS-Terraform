# VPC for EKS Cluster
resource "aws_vpc" "primary" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    environment = var.environment
    Name        = "${var.environment}-eks-vpc"
  }

}

# VPC for RDS Database
resource "aws_vpc" "secondary" {
  cidr_block = "172.31.0.0/16"

  tags = {
    environment = var.environment
    Name        = "${var.environment}-rds-vpc"
  }

}

# DHCP Options
resource "aws_vpc_dhcp_options" "main" {
  domain_name_servers = ["AmazonProvidedDNS"]
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = aws_vpc.primary.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}
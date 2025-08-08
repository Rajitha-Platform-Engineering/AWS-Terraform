resource "aws_eks_cluster" "main" {
  name     = "test-io-${var.environment}"
  role_arn = var.role_arn_primary
  version  = var.eks_cluster_version

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = [var.eks_subnet_id_primary, var.eks_subnet_id_secondary]
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = {
    environment = var.environment
  }

}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "system"
  version         = aws_eks_cluster.main.version
  node_role_arn   = var.role_arn_secondary
  instance_types  = [var.instance_type]
  subnet_ids      = [var.eks_subnet_id_primary, var.eks_subnet_id_secondary]

  tags = {
    environment                                              = var.environment
    "k8s.io/cluster-autoscaler/enabled"                      = "true"
    "k8s.io/cluster-autoscaler/${aws_eks_cluster.main.name}" = "owned"
  }

  scaling_config {
    desired_size = var.min_node_count
    max_size     = var.max_node_count
    min_size     = var.min_node_count
  }

  update_config {
    max_unavailable = 1
  }

}
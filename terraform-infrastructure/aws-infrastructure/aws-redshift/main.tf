resource "aws_redshift_subnet_group" "main" {
  name       = "${var.environment}-redshift-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.environment}-redshift-subnet-group"
  }
}

resource "aws_redshift_cluster" "main" {
  cluster_identifier        = "${var.environment}-redshift"
  database_name             = var.database_name
  master_username           = var.master_username
  master_password           = var.master_password
  node_type                 = var.node_type
  cluster_type              = var.number_of_nodes > 1 ? "multi-node" : "single-node"
  number_of_nodes           = var.number_of_nodes
  cluster_subnet_group_name = aws_redshift_subnet_group.main.name
  vpc_security_group_ids    = [var.security_group_id]
  skip_final_snapshot       = true
  publicly_accessible       = false
  encrypted                 = true

  tags = {
    Name = "${var.environment}-redshift"
  }
}

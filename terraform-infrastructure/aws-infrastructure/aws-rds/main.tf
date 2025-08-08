resource "aws_db_instance" "main" {
  identifier             = "${var.environment}-rds"
  allocated_storage      = 20
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  apply_immediately      = true
  publicly_accessible    = true
  db_subnet_group_name   = var.rds_subnet_group_id
  vpc_security_group_ids = [var.rds_security_group_id]

  tags = {
    Name = "${var.environment}-rds"
  }

}
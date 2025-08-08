resource "aws_glue_catalog_database" "main" {
  name = "${var.environment}_glue_catalog"
}

resource "aws_glue_crawler" "main" {
  name          = "${var.environment}-glue-crawler"
  role          = var.glue_iam_role_arn
  database_name = aws_glue_catalog_database.main.name

  s3_target {
    path = "s3://${var.data_lake_bucket}/${var.data_lake_prefix}"
  }

  schedule = var.crawler_schedule

  tags = {
    Name = "${var.environment}-glue-crawler"
  }
}

resource "aws_glue_job" "main" {
  name         = "${var.environment}-glue-etl-job"
  role_arn     = var.glue_iam_role_arn
  glue_version = "4.0"

  command {
    name            = "glueetl"
    script_location = "s3://${var.scripts_bucket}/${var.etl_script_key}"
    python_version  = "3"
  }

  default_arguments = {
    "--job-language"        = "python"
    "--enable-metrics"      = "true"
    "--enable-auto-scaling" = "true"
  }

  number_of_workers = var.number_of_workers
  worker_type       = var.worker_type

  tags = {
    Name = "${var.environment}-glue-etl-job"
  }
}

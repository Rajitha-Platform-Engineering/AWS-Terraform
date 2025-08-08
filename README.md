# **test SaaS Cloud Native**

This repository includes the HCL (Terraform) files which provisions all the required AWS resources for test application.
Basically, test application is containerised and runs as containers on top of EKS platform. The Terraform code creates
an AWS EKS cluster with one node pool, VPC, public subnets, S3 bucket to store the Terraform state files, RDS instance,
VPC endpoints from the EKS cluster to ECR and RDS, IAM roles and security groups.
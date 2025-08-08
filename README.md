# 🚀 AWS Terraform Infrastructure

This repository contains modular, production-ready Terraform code for provisioning and managing a full-stack cloud platform on AWS. The infrastructure is designed around a **Kubernetes-native architecture** with integrated **data platform capabilities**, observability stack, and secrets management — built to support scalable, data-driven applications.

---

## 🏗️ Architecture Overview

The platform is structured into three layers:

### 1. Cloud Infrastructure (AWS)
Core AWS resources provisioned via reusable Terraform modules:

| Module | Description |
|--------|-------------|
| `aws-vpc` | Virtual Private Cloud with public/private subnets |
| `aws-subnet` | Subnet provisioning across availability zones |
| `aws-internet-gateway` | Internet gateway for public traffic routing |
| `aws-route-table` | Route table associations for network traffic control |
| `aws-security-group` | Security group rules for network access control |
| `aws-eks-cluster` | Managed Kubernetes cluster (EKS) with node groups |
| `aws-iam-role` | IAM roles and policies following least-privilege principles |
| `aws-rds` | Managed relational database (MySQL/PostgreSQL) |
| `aws-s3` | S3 buckets for object storage and Terraform remote state |
| `aws-ecr` | Elastic Container Registry for private Docker images |
| `aws-vpc-endpoint` | Private VPC endpoints for secure AWS service access |
| `aws-cognito-user-pool` | User authentication and authorization via Cognito |

### 2. Data Platform
A dedicated data engineering layer for ingestion, processing, storage, and analytics:

| Module | Description |
|--------|-------------|
| `aws-kinesis` | Real-time data streaming with Kinesis Streams and Firehose for S3 delivery |
| `aws-msk` | Managed Streaming for Apache Kafka (MSK) for event-driven architectures |
| `aws-glue` | Serverless ETL jobs with Glue crawler for automatic schema discovery |
| `aws-redshift` | Cloud data warehouse for large-scale analytics and BI workloads |

### 3. Platform Components (Kubernetes)
Services deployed onto EKS for observability, security, and traffic management:

| Component | Description |
|-----------|-------------|
| **Prometheus + Alertmanager** | Metrics collection and alerting |
| **Grafana** | Observability dashboards with OAuth (Cognito) integration |
| **Loki** | Centralized log aggregation |
| **HashiCorp Vault** | Secrets management with AppRole and JWT authentication |
| **External Secrets Operator** | Syncs secrets from Vault into Kubernetes |
| **NGINX Ingress Controller** | Manages external HTTP/S traffic routing |
| **Cert-Manager** | Automated TLS certificate provisioning (Let's Encrypt) |
| **Elasticsearch** | Search and log analytics engine |
| **MySQL** | In-cluster relational database |

---

## 🔄 Why This Setup?

This platform is designed to support a **modern data-driven application** that requires:

- **Real-time ingestion** — Kinesis and MSK handle high-throughput event streams from application and IoT sources
- **Batch processing** — Glue ETL jobs transform raw data in S3 (data lake) into structured formats
- **Analytics at scale** — Redshift serves as the central data warehouse for BI tools and reporting
- **Secure, scalable compute** — EKS provides a Kubernetes platform for containerised workloads with auto-scaling
- **Zero-trust secrets** — Vault with ESO ensures no secrets are hardcoded; all credentials are dynamically injected
- **Full observability** — Prometheus, Grafana, Loki, and Alertmanager provide metrics, logs, and alerting end-to-end

---

## 🌍 Environments

| Environment | Description |
|-------------|-------------|
| `staging` | Pre-production environment for integration testing |
| `production` | Production-grade environment (in progress) |

---

## 🗃️ Remote State

Terraform state is stored remotely in **AWS S3** with environment-scoped state files, enabling team collaboration and state locking.

---

## 🔐 Security Highlights

- IAM roles follow **least-privilege** principles
- All secrets managed via **HashiCorp Vault** — no hardcoded credentials
- Network segmentation via **VPC, subnets, and security groups**
- TLS enforced across all ingress endpoints via **Cert-Manager**
- Cognito handles **user authentication** for platform services

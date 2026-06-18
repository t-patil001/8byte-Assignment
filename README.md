# 8Byte Assignment

## Overview

This project demonstrates a production-style DevOps setup for deploying a simple frontend and backend application using AWS, Terraform, Docker, GitHub Actions, and self-hosted monitoring.

The solution implements:

* Infrastructure as Code using Terraform
* Separate Development and Production environments
* CI/CD with GitHub Actions
* Container image security scanning
* Automated deployments
* Monitoring and observability
* Backup strategy
* Cost optimization measures
* Self-hosted services

---

# Architecture

```
GitHub Repository
        │
        │ Pull Request
        ▼
GitHub Actions (PR Checks)
        │
        ├── Unit Tests
        ├── pip-audit Dependency Scan
        └── Trivy Container Scan
        │
        ▼
Merge to main
        │
        ▼
GitHub Actions (Staging Pipeline)
        │
        ├── Build Docker Images
        ├── Push Images to ECR
        └── Deploy to EC2 (Docker Compose)
        │
        ▼
Development Environment
        │
        ▼
Manual Approval
        │
        ▼
Production Pipeline
        │
        ├── Build Images
        ├── Push to ECR
        └── Deploy to Production EC2
```

---

# Repository Structure

```
.
├── app
│   ├── backend
│   ├── frontend
│   └── tests
│
├── terraform
│   ├── DEV
│   ├── PROD
│   └── modules
│
├── .github
│   └── workflows
│       ├── pr.yml
│       ├── staging.yml
│       └── production.yml
│
└── README.md
```

---

# Infrastructure Setup

Infrastructure is provisioned using Terraform.

## Initialize Terraform

```bash
terraform init
```

## Validate

```bash
terraform validate
```

## Plan

```bash
terraform plan
```

## Apply

```bash
terraform apply
```

## Destroy

```bash
terraform destroy
```

---

# Terraform Remote Backend

After uncommenting backend.tf:

```bash
terraform init -reconfigure
```

Terraform state is stored remotely in S3.

---

# Application

## Backend

FastAPI application

Run locally:

```bash
cd app/backend

pip install -r requirements.txt

uvicorn main:app --host 0.0.0.0 --port 8032
```

---

## Frontend

Simple static HTML page.

---

# Docker

## Build Backend

```bash
docker build -t backend ./app/backend
```

## Run Backend

```bash
docker run -p 8032:8032 backend
```

---

## Build Frontend

```bash
docker build -t frontend ./app/frontend
```

## Run Frontend

```bash
docker run -p 8081:80 frontend
```

---

# CI/CD Pipeline

Three GitHub Actions workflows are used.

---

## 1. PR Checks

Triggered on:

```yaml
pull_request
```

Performs:

### Unit Testing

```bash
pytest
```

### Dependency Vulnerability Scan

```bash
pip-audit -r app/backend/requirements.txt
```

### Container Security Scan

```bash
Trivy
```

High and Critical vulnerabilities cause the PR to fail.

---

## 2. Staging Deployment

Triggered on:

```yaml
push:
  branches:
    - main
```

Pipeline flow:

1. Detect changed files
2. Build Docker images
3. Push images to Amazon ECR
4. SSH into Development EC2
5. Pull latest images
6. Restart containers

---

## 3. Production Deployment

Triggered manually using:

```yaml
workflow_dispatch
```

Features:

* Manual approval
* Separate production environment
* Independent ECR repositories
* SSH deployment to Production EC2

---

# Git Commands Used

Create feature branch:

```bash
git checkout -b feature-test
```

Add files:

```bash
git add .
```

Commit:

```bash
git commit -m "message"
```

Push:

```bash
git push origin feature-test
```

Create Pull Request

Merge into:

```text
feature-test → main
```

Main branch automatically triggers staging deployment.

Production deployment is executed manually.

---

# Security Considerations

## Secrets Management

Sensitive values are stored in GitHub Secrets:

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* STAGING_EC2_HOST
* STAGING_EC2_USER
* STAGING_EC2_SSH_KEY
* PROD_EC2_HOST
* PROD_EC2_USER
* PROD_EC2_SSH_KEY

Secrets are never hardcoded.

---

## Dependency Scanning

Using:

```bash
pip-audit
```

to detect vulnerable Python packages.

---

## Container Scanning

Using:

```bash
Trivy
```

to scan Docker images.

Pipeline fails if HIGH or CRITICAL vulnerabilities are detected.

---

## Environment Isolation

Separate:

* Development environment
* Production environment

Separate:

* EC2 instances
* ECR repositories

---

# Monitoring

Self-hosted SigNoz is used instead of paid monitoring solutions.

Collected metrics:

### Host Metrics

* CPU
* Memory
* Disk
* Network

### Logs

* Container logs
* Backend logs

### Dashboards

* PostgreSQL dashboard
* Redis dashboard
* Infrastructure dashboard

---

# Backup Strategy

Self-hosted PostgreSQL and Redis are used.

Docker Compose services are periodically backed up.

Database backups can be restored quickly without depending on managed cloud databases.

---

# Self-hosted Components

Instead of using managed services, self-hosted alternatives are deployed.

## PostgreSQL

Using Docker Compose.

Benefits:

* Lower cost
* Full control

---

## Redis

Using Docker Compose.

Benefits:

* No additional managed service charges

---

## SigNoz

Used instead of:

* Datadog
* New Relic

Benefits:

* Open source
* Self-hosted
* Significant cost savings

---

# Cost Optimization Measures

## Self-hosted Databases

Instead of Amazon RDS:

* PostgreSQL in Docker
* Redis in Docker

Reduces monthly infrastructure costs.

---

## Self-hosted Monitoring

Instead of New Relic or Datadog:

* SigNoz

Provides observability without licensing fees.

---

## Docker Compose Deployment

Avoided Kubernetes overhead for this assignment.

Benefits:

* Lower resource usage
* Easier management
* Reduced costs

---

## Change-based Deployment

Using:

```yaml
dorny/paths-filter
```

Only changed components are rebuilt and deployed.

This reduces:

* Build time
* ECR usage
* Compute costs

---

## Separate Development and Production

Prevents unnecessary resource consumption and improves reliability.

---

# Best Practices Implemented

✅ Infrastructure as Code

✅ CI/CD

✅ Pull Request based workflow

✅ Separate environments

✅ Unit testing

✅ Dependency scanning

✅ Container scanning

✅ Secret management

✅ Manual production deployment

✅ Self-hosted monitoring

✅ Backup strategy

✅ Cost optimization

✅ Environment isolation

✅ Dockerized applications

---

# Technologies Used

### Cloud

* AWS

### IaC

* Terraform

### CI/CD

* GitHub Actions

### Containers

* Docker

### Registry

* Amazon ECR

### Web Server

* Nginx

### Backend

* FastAPI

### Security

* pip-audit
* Trivy

### Monitoring

* SigNoz

### Databases

* PostgreSQL
* Redis

### Source Control

* GitHub

---

# Author

Tirthraj Patil

DevOps Engineer

# Apache Superset on AWS — Business-Focused Deployment

## Overview

This project demonstrates how to deploy Apache Superset in AWS with a strong focus on business usability, reliability, and cost-effectiveness.

Since the primary goal was to let the client evaluate Superset as a BI tool, the project was designed to provide the best possible user experience — despite the lack of a provided dataset or specific business use case. To address this, the instance is preloaded with standard example dashboards and charts.

## Key Objectives

- Deliver a **ready-to-use Superset instance** with sample dashboards.
- Ensure **stable and reusable access** via HTTPS and a consistent domain.
- Minimize infrastructure costs while maintaining a professional, production-like experience.
- Fully automate deployment using **Terraform**, **Bash**, and **Docker**.

## Superset Patch

At the time of deployment, a known issue prevented Superset from loading sample datasets (due to a cache-related bug). After analyzing GitHub issues and documentation, I implemented a **custom patch** to fix the problem. The deployment uses a custom-built Superset image with this fix applied.

## Architecture Summary

- **Single EC2 instance** (cost-effective, no horizontal scaling needed)
- **Superset running in Docker Compose** (custom image with patch)
- **Route 53** — domain routing
- **CloudFront** — global content delivery and caching
- **ACM Certificate** — automatic HTTPS support via TLS
- **Custom domain**: [https://superset.zakrzewski.me](https://superset.zakrzewski.me)

This infrastructure ensures the client can access Superset reliably from the same domain without worrying about dynamic IP changes or re-deployment side effects.

## Why Single EC2 Instead of Cluster?

While Superset supports clustered deployment with Celery workers and separate services, this project deliberately uses a single virtual machine. This approach offers:

- Lower infrastructure and DevOps cost
- Faster provisioning and teardown
- Sufficient performance for demonstration purposes
- Alignment with the project’s core objective: BI tool evaluation, not production scaling

## Repository Structure

The project is divided into two independent but tightly integrated components:

### 1. Superset Image (with patch)

- Based on `apache/superset`
- Custom patch applied to resolve dataset loading bug
- Built via `Dockerfile` from GitHub repo: [superset_bi](https://github.com/alexzakrpl/superset_bi)

### 2. AWS Infrastructure (Terraform)

- Fully automated provisioning of:
  - VPC and Security Groups
  - EC2 instance with user data script
  - DNS via Route 53
  - TLS Certificate via AWS ACM
  - CloudFront distribution
- `user_data.sh` automatically clones the patched Superset repo and starts the service

## Quick Start

> ⚠️ Before starting, make sure you have AWS credentials and Terraform installed.

```bash
git clone https://github.com/alexzakrpl/superset-aws-deployment.git
cd superset-aws-deployment

# Configure variables in terraform.tfvars or .env
# Then deploy the infrastructure
terraform init
terraform apply

AWS Challenge 17: Managed Kubernetes (EKS) with Terraform

Welcome to my Amazon EKS deployment project! This repository demonstrates a complete, automated infrastructure-as-code (IaC) setup to run a scalable web application on AWS.

🏗️ Architecture Overview

The deployment follows AWS best practices for security and high availability:

    Custom VPC: Isolated network with 2 Public Subnets and 2 Private Subnets across different Availability Zones (AZs).

    Security: Worker nodes are hosted in Private Subnets, accessing the internet only via a NAT Gateway for enhanced security.

    EKS Cluster: A managed Kubernetes control plane orchestrating a Node Group of t3.medium instances.

    Ingress Controller: Uses the AWS Load Balancer Controller to automatically provision an Application Load Balancer (ALB).

    Autoscaling: Implements Horizontal Pod Autoscaler (HPA) using metrics-server to scale pods dynamically based on CPU utilization.

📂 Project Structure

As seen in my local environment, the project is organized as follows:

    /infra: Terraform files for VPC, EKS Cluster, and Networking.

    /ecr: Terraform files for the Private ECR Repository.

    /app: Contains the Dockerfile, web source (index.html), and Kubernetes manifests (deploy.yaml, svc.yaml, ingress.yaml).

🚀 Deployment Steps (Brief)

    Infrastructure: cd infra/ && terraform apply.

    ECR: cd ecr/ && terraform apply.

    App: Build Docker image, push to ECR, and apply kubectl manifests in /app.

💸 Cost Optimization (AWS Academy Lab)

Budget management is critical. The EKS control plane has a fixed cost of ~$0.10/hour. I followed an ephemeral deployment strategy: provisioning the environment only for testing and destroying it immediately after.

Author: Ricardo Martín Díaz
Date: March 2026
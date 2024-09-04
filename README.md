# Deploy Dynamic Web App on AWS with Terraform Docker Amazon ECR & ECS

## Project Overview

This project demonstrates how to deploy a dynamic web application on AWS using Terraform for infrastructure as code, Docker for containerization, and Amazon ECR and ECS for container orchestration. The architecture is designed to be scalable, highly available, and secure, leveraging various AWS services to achieve these goals.

## Use Case

This project is ideal for deploying a web application that requires:

* Scalability: With ECS and Auto Scaling, the application can handle varying loads.
  
* High Availability: Utilizing multiple availability zones and load balancing.
  
* Security: By segregating application and database components into private subnets and securing access with IAM roles and security groups.
  
* Automated Infrastructure: With Terraform automating the setup and configuration of AWS resources.


## Prerequisites

Before you start, make sure you have the following tools installed:

* Terraform: Installed and configured.
* Docker: Installed for container creation.
* Git: Installed and connected to your GitHub account.
* AWS CLI : configured with appropriate IAM user credentials.
* VS Code: With extensions for Terraform and Docker
* SSH Key Pairs: For secure connections.

You will also need:

* An AWS account
* GitHub account for version control


## Architecture Diagram

![](./images/Architecture%20for%20hosting%20a%20Dynamic%20Web%20app%20using%20Terraform%20Docker%20Amazon%20ECR%20and%20ECS.jpg)

The architecture includes:

* Amazon Route 53: DNS service to direct user traffic.
* VPC with Subnets:
    *  2 Public Subnets (10.0.0.0/24 and 10.0.1.0/24) for the NAT Gateway and ALB.
    *  4 Private Subnets for App (10.0.2.0/24, 10.0.3.0/24) and DB (10.0.4.0/24, 10.0.5.0/24).
* NAT Gateway: To allow instances in private subnets to access the internet.
* Application Load Balancer (ALB): For distributing incoming traffic across ECS services.
* Amazon ECS (Elastic Container Service): To run Docker containers.
* Amazon ECR (Elastic Container Registry): To store Docker images.
* Amazon RDS (Relational Database Service): For database services with a master and standby instance.
* Amazon S3: For storing environment files.
* Amazon DynamoDB: For locking Terraform state.
* IAM Roles: To ensure secure access to services.
* Auto Scaling Group: To ensure the app scales based on demand.

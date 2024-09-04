# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
}

# vpc variables
variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
}

variable "pub_eligant_subnet_az1_cidr" {
  description = "public eligant subnet az1 cidr block"
  type        = string
}

variable "pub_eligant_subnet_az2_cidr" {
  description = "public eligant subnet az2 cidr block"
  type        = string
}

variable "private_eligantapp_subnet_az1_cidr" {
  description = "private eligant App subnet az1 cidr block"
  type        = string
}

variable "private_eligantapp_subnet_az2_cidr" {
  description = "private eligant App subnet az2 cidr block"
  type        = string
}

variable "private_eligantdata_subnet_az1_cidr" {
  description = "private eligant Database subnet az1 cidr block"
  type        = string
}

variable "private_eligantdata_subnet_az2_cidr" {
  description = "private eligant Database subnet az2 cidr block"
  type        = string
}

# Security groups variables
variable "ssh_location" {
  description = "ip that can ssh into the server"
  type        = string
}

# rds varaiables
variable "database_snapshot_identifier" {
  description = "database snap shot"
  type        = string
}

variable "database_instance_class" {
  description = "database instance type"
  type        = string
}

variable "database_instance_identifier" {
  description = "database instance identifier"
  type        = string
}

variable "multi_az_deployment" {
  description = "create a standby db instance"
  type        = bool
}

# acm variables
variable "domain_name" {
  description = "domain name"
  type        = string
}

variable "subject_alternative_names" {
  description = "sub domain names"
  type        = string
}

# S3 variables
variable "env_file_bucket_name" {
  description = "s3 bucket name"
  type        = string
}

variable "env_file_name" {
  description = "env file name"
  type        = string
}

# ecs variables
variable "architecture" {
  description = "ecs cpu architecture"
  type        = string
}

variable "container_image" {
  description = "container image uri"
  type        = string
}

# route53 variables
variable "record_name" {
  description = "sub domain name"
  type = string
}

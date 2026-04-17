terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
    region = var.aws_region
}

module "vpc" {
    source = "./modules/vpc"
    project_name = var.project_name
    environment = var.environment
}

module "ec2" {
    source = "./modules/ec2"
    project_name = var.project_name
    environment = var.environment
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.public_subnet_id
    instance_type = var.ec2_instance_type
    allowed_ssh_cidr = var.allowed_ssh_cidr
}

resource "aws_s3_bucket" "app_storage" {
    bucket = "${var.project_name}-${var.environment}-storage"

    tags = {
        Name        = "${var.project_name}-storage"
        Environment = var.environment
    }
}

resource "aws_s3_bucket_versioning" "app_storage" {
    bucket = aws_s3_bucket.app_storage.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_public_access_block" "app_storage" {
    bucket = aws_s3_bucket.app_storage.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true  
  
}
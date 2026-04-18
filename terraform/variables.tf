variable "aws_region" {
    description = "The AWS region to deploy resources in."
    type        = string
    default     = "us-east-1"
}

variable "environment" {
    description = "The environment to deploy resources."
    type        = string
    default     = "dev"
}

variable "project_name" {
    description = "The name of the project for tagging and naming resources."
    type        = string
    default     = "iac-pipeline"
}

variable "ec2_instance_type" {
    description = "The type of EC2 instance to deploy."
    type        = string
    default     = "t2.micro"
}

variable "allowed_ssh_cidr" {
    description = "The CIDR block allowed to access EC2 instances via SSH."
    type        = string
    default     = "0.0.0.0/0"
}

variable "public_key" {
    description = "The public key for EC2 instance SSH access."
    type        = string
}
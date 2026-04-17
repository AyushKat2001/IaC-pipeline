output "ec2_public_ip" {
    description = "The public IP address of the EC2 instance."
    value       = module.ec2.public_ip
}

output "ec2_instance_id" {
    description = "The ID of the EC2 instance deployed."
    value       = module.ec2.instance_id
}

output "vpc_id" {
    description = "The ID of the VPC created."
    value       = module.vpc.vpc_id
}

output "s3_bucket_name" {
    description = "The name of the S3 bucket created for application storage."
    value       = aws_s3_bucket.app_storage.bucket
}
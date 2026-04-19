terraform { 
  backend "s3" {
    bucket = "terraform-state-ayush"
    key    = "path/to/my/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt = true
    
  }
} # Configure Terraform to use S3 for state storage and DynamoDB for state locking.
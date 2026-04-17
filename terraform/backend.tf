terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "path/to/my/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "value"
    encrypt = true
    
  }
}
output "public_ip" {
    value = aws_instance.app.public_ip
    description = "Public IP address of the EC2 instance"
  
}

output "instance_id" {
    value = aws_instance.app.id
    description = "ID of the EC2 instance"
  
}  # Output the public IP address and instance ID of the EC2 instance created in this module for use in other modules or for informational purposes.
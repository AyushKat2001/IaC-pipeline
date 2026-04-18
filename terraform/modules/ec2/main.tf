resource "aws_key_pair" "deployer" {
    key_name   = "${var.project_name}-key"
    public_key = file("~/.ssh/id_rsa.pub")
  
}

resource "aws_security_group" "app" {
    name        = "${var.project_name}-sg"
    description = "Security group for ${var.project_name} EC2 instances"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.allowed_ssh_cidr]
        description = "Allow SSH access from ${var.allowed_ssh_cidr}"
    }
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP access from anywhere"
    }

    ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Node.js app port"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
    tags = {
        Name        = "${var.project_name}-sg"
        Environment = var.environment
    }
}

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "app" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name      = aws_key_pair.deployer.key_name
    subnet_id     = var.subnet_id
    vpc_security_group_ids = [aws_security_group.app.id]

    root_block_device {
      volume_size = 20
      volume_type = "gp3"
    }

    tags = {
        Name        = "${var.project_name}-server"
        Environment = var.environment
    }
  
}
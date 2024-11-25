# Provider Configuration
provider "aws" {
  region = "us-east-1"
  # Credentials are loaded from environment variables or AWS CLI configuration
  # Set environment variables: AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
}

# Create a Security Group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH access to EC2 instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Use an Existing Key Pair or Create a Key Pair Resource
resource "aws_key_pair" "my_key" {
  key_name   = "albin"
  public_key = file("~/.ssh/id_rsa.pub")  # Path to your public SSH key file
}

# Create an EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-0866a3c8686eaeeba"  # Use a valid AMI ID (Ubuntu 20.04, for example)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name  # Reference the key pair resource
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "MyEC2Instance"
  }

  # Provisioning commands for Docker installation
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              EOF
}

# Output the public IP of the EC2 instance
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}

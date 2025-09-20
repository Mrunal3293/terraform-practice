# Key pair (creates in AWS automatically)
resource "aws_key_pair" "nginx_key" {
  key_name   = "nginx-key"
  public_key = file("nginx-terra-key.pub") # path of public key created using ssh-keygen
}


# security group allowing 22 to ssh and 80 to http
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "nginx_ec2" {
  ami                    = "ami-0ddac4b9aed8d5d46"
  instance_type           = "t3.micro"
  key_name                = aws_key_pair.nginx_key.key_name
  vpc_security_group_ids  = [aws_security_group.nginx_sg.id]

  user_data = file("install_nginx.sh") # script to install nginx with .sh file

  tags = {
    Name = "nginx-ec2"
  }
}
resource "aws_instance" "first_vpc_instance" {
  ami                         = "ami-0005e0cfe09cc9050"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.private_key.key_name
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  user_data                   = <<EOF
#!/bin/bash         
sudo su         
yum update -y           
yum install httpd -y            
systemctl start httpd           
systemctl enable httpd          
echo "<html><h1> Welcome to Whizlabs Public Server</h1><html>" > /var/www/html/index.html
EOF
  tags = {
    Name = "First_VPCs_EC2"
  }
}

### Second infrastructure
resource "aws_instance" "second_vpc_instance" {
  ami                         = "ami-0005e0cfe09cc9050"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.private_key.key_name
  subnet_id                   = aws_subnet.private_subnet.id
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  tags = {
    Name = "Second_VPCs_EC2"
  }
}

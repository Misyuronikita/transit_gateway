resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "private_key" {
  key_name   = "ec2_ssh_key"
  public_key = tls_private_key.private_key.public_key_openssh
  tags = {
    Name = "ec2_ssh_key"
  }
}

resource "local_file" "ssh-key" {
  filename = "${aws_key_pair.private_key.key_name}.pem"
  content  = tls_private_key.private_key.private_key_pem
}

resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.ec2_key.private_key_pem
  filename        = "${path.root}/${var.project_name}-${var.environment}.pem"
  file_permission = "0600"
}

resource "random_id" "key_id" {
  byte_length = 4
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.project_name}-${var.environment}-${random_id.key_id.hex}"
  public_key = tls_private_key.ec2_key.public_key_openssh
}
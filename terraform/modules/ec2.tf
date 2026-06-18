resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true
  
  key_name = aws_key_pair.generated_key.key_name
  
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  user_data = file("${path.module}/../../scripts/bootstrap.sh")
  
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-ec2"
    }
  )
}
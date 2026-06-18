output "vpc_id" {
  value = module.infra.vpc_id
}

output "public_subnet_id" {
  value = module.infra.public_subnet_id
}

output "private_subnet_id" {
  value = module.infra.private_subnet_id
}

output "ec2_instance_id" {
  value = module.infra.ec2_instance_id
}

output "ec2_public_ip" {
  value = module.infra.ec2_public_ip
}

output "ec2_public_dns" {
  value = module.infra.ec2_public_dns
}

output "rds_endpoint" {
  value = module.infra.rds_endpoint
}

output "frontend_repository_url" {
  value = module.infra.frontend_repository_url
}

output "backend_repository_url" {
  value = module.infra.backend_repository_url
}

output "frontend_repository_name" {
  value = module.infra.frontend_repository_name
}

output "backend_repository_name" {
  value = module.infra.backend_repository_name
}
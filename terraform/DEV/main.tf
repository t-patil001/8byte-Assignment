module "infra" {

  source = "../modules"

  project_name = var.project_name
  environment  = var.environment

  aws_region = var.aws_region

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  private_subnet_cidr_2 = var.private_subnet_cidr_2

  availability_zone = var.availability_zone

  instance_type = var.instance_type
  ami_id         = var.ami_id

  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  db_instance_class   = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
}
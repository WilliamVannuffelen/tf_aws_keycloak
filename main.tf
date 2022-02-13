data "aws_availability_zones" "available" {
    state = "available"
}

module "networking" {
    source = "./modules/networking"
    namespace = var.namespace
    environment = var.environment
}

module "database" {
    source = "./modules/database"
    namespace = var.namespace
    environment = var.environment
    subnet_group_name = module.networking.subnet_group_name
    db_username = var.db_username
    db_password = var.db_password
    sql_sg = module.networking.sql_sg.id
}

module "ec2" {
    source = "./modules/ec2"
    namespace = var.namespace
    environment = var.environment
    public_key_path = var.public_key_path
    bastion_subnet_id = module.networking.bastion_subnet_id
    bastion_sg = module.networking.bastion_sg
    bastion_temp_sg = module.networking.bastion_temp_sg
}
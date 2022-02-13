output "bastion_public_ip" {
    value = module.ec2.bastion_public_ip
}
output "rds_hostname" {
    value = module.database.rds_hostname
}
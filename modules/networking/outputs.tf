output "subnet_group_name" {
    value = aws_db_subnet_group.kc_sng.name
}

output "bastion_subnet_id" {
    value = module.vpc.public_subnets[0]
}

output "bastion_sg" {
    value = aws_security_group.allow_ssh.id
}
output "bastion_temp_sg" {
    value = aws_security_group.allow_http.id
}

output "sql_sg" {
    value = aws_security_group.allow_sql_from_vpc
}
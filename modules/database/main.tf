resource "aws_db_instance" "kc_db" {
    allocated_storage       = 5
    engine                  = "mysql"
    engine_version          = "8.0.27"
    instance_class          = "db.t2.micro"
    db_name                 = "${var.namespace}db"
    db_subnet_group_name    = var.subnet_group_name
    username                = var.db_username
    password                = var.db_password
    skip_final_snapshot     = true
    vpc_security_group_ids  = [var.sql_sg]
}

resource "aws_db_parameter_group" "kc_db" {
    name = "${var.namespace}"
    family = "mysql8.0"
}
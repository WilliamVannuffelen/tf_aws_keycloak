variable "environment" {
    type = string
}

variable "namespace" {
    type = string
}

variable "db_username" {
    description = "RDS root username"
    type        = string
}

variable "db_password" {
    description = "RDS root user password"
    type        = string
    sensitive   = true
}

variable "subnet_group_name" {
    type = string
}

variable "sql_sg" {
    type = string
}
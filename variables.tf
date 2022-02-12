variable "region" {
    description = "AWS region"
    type = string
}

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

variable "public_key_path" {
    description = "Path to public key of ec2 keypair"
    type = string
}
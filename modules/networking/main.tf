data "aws_availability_zones" "available" {
    state = "available"
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 3.12.0"

    name                = "${var.namespace}-vpc"
    cidr                = "10.1.0.0/16"
    azs                 = [
        data.aws_availability_zones.available.names[0], 
        data.aws_availability_zones.available.names[1]
        ]
    public_subnets      = ["10.1.1.0/24","10.1.2.0/24"]
    private_subnets     = ["10.1.11.0/24","10.1.12.0/24","10.1.13.0/24"]
    enable_nat_gateway  = false

    tags = {
        Environment = var.environment
        Name        = var.namespace
    }
}

resource "aws_db_subnet_group" "kc_sng" {
    name = "${var.namespace}-sng"
    subnet_ids = [
        module.vpc.private_subnets[0],
        module.vpc.private_subnets[1]
    ]
    

    tags = {
        Environment = var.environment
        Name        = var.namespace
    }
}

resource "aws_security_group" "allow_ssh" {
    name = "${var.namespace}_allow_ssh"
    description = "allow ssh inbound"
    vpc_id = module.vpc.vpc_id

    ingress {
        description     = "ssh from anywhere"
        from_port       = 0
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Environment = var.environment
        Name        = var.namespace
    }
}

# temporary during testing phase! to allow HTTP/S to bastion for keycloak config TS
resource "aws_security_group" "allow_http" {
    name = "${var.namespace}_allow_http"
    description = "allow http/s inbound for keycloak"
    vpc_id = module.vpc.vpc_id

    ingress {
        description     = "http from anywhere"
        from_port       = 0
        to_port         = 8080
        protocol        = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    ingress {
        description     = "https from anywhere"
        from_port       = 0
        to_port         = 8443
        protocol        = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Environment = var.environment
        Name        = var.namespace
    }
}

resource "aws_security_group" "allow_sql_from_vpc" {
    name = "${var.namespace}_allow_sql_from_vpc"
    description = "allow sql inbound from vpc"
    vpc_id = module.vpc.vpc_id

    ingress {
        description     = "sql from vpc"
        from_port       = 0
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks     = ["10.1.1.0/24"]
    }
}
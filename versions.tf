terraform {
    backend "s3" {
        bucket = "s3backend-t7s7ygc5mwuqeb-state-bucket"
        key = "aws_keycloak/dev/terraform.tfstate"
        region = "eu-west-1"
        encrypt = true
        role_arn = "arn:aws:iam::850901712561:role/s3backend-t7s7ygc5mwuqeb-tf-assume-role"
        dynamodb_table = "s3backend-t7s7ygc5mwuqeb-state-lock"
    }
    required_version = ">= 1.1.5"

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 3.74.0"
        }
    }
}
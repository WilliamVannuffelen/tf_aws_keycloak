data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"] # canonical
}

resource "aws_key_pair" "ssh_key" {
    key_name    = "${var.namespace}_key"
    public_key  = file(var.public_key_path)

    tags = {
        Name = var.namespace
    }
}

resource "aws_instance" "bastion" {
    ami             = data.aws_ami.ubuntu.id
    instance_type   = "t3.micro"
    key_name        = aws_key_pair.ssh_key.key_name
    associate_public_ip_address = true
    subnet_id                   = var.bastion_subnet_id
    private_ip                  = "10.1.1.5"
    vpc_security_group_ids      = [var.bastion_sg]

    tags = {
        Environment = var.environment
        Name = var.namespace
    }
}
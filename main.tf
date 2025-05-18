provider "aws" {
  region = var.region
}

resource "aws_instance" "superset_instance" {
  ami                    = "ami-05548f9cecf47b442" # Amazon Linux 2 in us-east-1
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.superset_sg.id]

user_data = templatefile("${path.module}/user_data.sh", {
  superset_env = join("\n", [for key, value in var.superset_env : "${key}=${value}"])
  path         = path.module
})

  tags = {
    Name = "SupersetInstance"
  }
}

resource "aws_security_group" "superset_sg" {
  name        = "superset_sg"
  description = "Allow Superset HTTP access"

  ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

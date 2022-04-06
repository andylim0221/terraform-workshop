terraform {

  cloud {
    organization = "example-org-9cf8e7"
    workspaces {
      name = "terraform-workshop"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.27"
    }
  }

  required_version = ">=0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


resource "aws_instance" "app_server" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = var.instance_type

  tags = {
    Name = "Worklaod"
  }

  provisioner "local-exec" {
    command = "echo 'Hello World' > ./text.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Hello World' > ./text.txt"
  }
}
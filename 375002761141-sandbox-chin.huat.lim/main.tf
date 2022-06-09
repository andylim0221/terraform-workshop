terraform {

  cloud {
    organization = "example-org-9cf8e7"

    workspaces {
      name = "AWS-375002761141"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "dynatrace_iam_role" {
  source = "./modules/dynatrace-iam-role"

}

data "aws_iam_instance_profile" "dynatrace" {
  name = "Dynatrace_ActiveGate_role"
}

resource "aws_instance" "dynatrace_gateway" {
  instance_type        = "t2.medium"
  ami                  = "ami-087c17d1fe0178315"
  iam_instance_profile = data.aws_iam_instance_profile.dynatrace.name
  tags = {
    "Name"        = "AL2_Dynatrace_ActiveGate"
    "Purpose"     = "Test"
    "Environment" = "Prod"
  }
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo Hello World"
  }
}

resource "null_resource" "example-2" {
  provisioner "local-exec" {
    command = "echo Hello Terraform"
  }
}


resource "null_resource" "example-3" {
  provisioner "local-exec" {
    command = "echo Hello Terraform-2"
  }
}
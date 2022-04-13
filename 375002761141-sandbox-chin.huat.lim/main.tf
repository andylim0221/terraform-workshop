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

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo Hello World"
  }
}
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
      version = "~>4.8.0"
    }
  }

  required_version = ">=0.14.9"
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "eu-central-1"
  alias  = "secondary_region"
}

module "test_modules" {
  source = "./modules/"

  name          = "test-lb"
  function_name = "account"
}



resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.lb.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"
  providers = {
    aws = aws.secondary_region
  }

  function_name = "my-lambda1"
  description   = "My awesome lambda function"
  handler       = "index.index_handler"
  runtime       = "python3.8"

  source_path = "./src/lambda-function1.py"

  tags = {
    Name = "my-lambda1"
  }
}


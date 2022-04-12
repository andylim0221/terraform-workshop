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

  name        = "test-lb"
  policy_name = "test-policy"
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
  name = "dontettetetets"
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

data "aws_eks_cluster" "sandbox" {
  name = "sandbox-eks-cluster"
}

data "aws_iam_role" "eks" {
  name = "eks"
}

resource "aws_eks_cluster" "sandbox" {
  name     = data.aws_eks_cluster.sandbox.name
  role_arn = data.aws_iam_role.eks.arn
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    public_access_cidrs = [
      "0.0.0.0/0",
    ]
    security_group_ids = [
      "sg-165adf35",
    ]
    subnet_ids = [
      "subnet-06975a27",
      "subnet-4b6aaa14",
      "subnet-57ff3831",
      "subnet-8428bfc9",
    ]
  }
}
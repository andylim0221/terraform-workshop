variable "instance_type" {
  type        = string
  description = "Instance type for EC2"
  default     = "t2.micro"
}

variable "subnet_ids" {
  description = "Available cidr blocks for subnets."
  type        = list(string)
  default = [
    "subnet-06975a27",
    "subnet-4b6aaa14",
    "subnet-57ff3831",
    "subnet-8428bfc9",
  ]
}

variable "example" {}

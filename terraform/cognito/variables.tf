variable "service_name" {
  default = "cognito"
}
variable "service_instance_name" {}
variable "environment_name" {}

variable "region" {
  default = "us-east-1"
}

variable "vpc" {
  default = "vpc-74c2c81d"
}

locals {
  aws_service_name = "tf-${var.service_instance_name}"
  common_tags = {
    Name = var.service_instance_name
    ServiceName = var.service_name
    Environment = var.environment_name
  }
}

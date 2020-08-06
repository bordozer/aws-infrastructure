variable "service_name" {
  default = "jlambda_security"
}
variable "environment_name" {}

variable "region" {
  default = "us-east-1"
}

variable "vpc" {
  default = "vpc-74c2c81d"
}

locals {
  service_instance_name = "${var.service_name}-${var.environment_name}"
  aws_service_name = "tf-${local.service_instance_name}"
  common_tags = {
    Name = local.service_instance_name
    ServiceName = var.service_name
    Environment = var.environment_name
  }
}

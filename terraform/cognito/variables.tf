variable "service_name" {}
variable "environment_name" {}

variable "region" {
  default = "us-east-1"
}
variable "vpc" {
  default = "vpc-74c2c81d"
}

variable "git_hash" {}
variable "git_branch" {}
variable "git_repo_name" {}

locals {
  service_instance_name = "${var.service_name}-${var.environment_name}"
  aws_service_name = "tf-${local.service_instance_name}"
  common_tags = {
    Name          = local.service_instance_name
    ServiceName   = var.service_name
    Environment   = var.environment_name
    CreatedBy     = "Terraform"
    GitRepoName   = var.git_repo_name
  }
}

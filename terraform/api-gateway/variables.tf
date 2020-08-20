variable "service_name" {}
variable "environment" {}

variable "git_hash" {}
variable "git_branch" {}
variable "git_repo_name" {}

variable "region" {
  default = "eu-west-3"
}
variable "vpc_id" {
  default = "vpc-74c2c81d"
}
variable "subnets" {
  default = [
    "subnet-08d6e761",
    "subnet-f2d79f89",
    "subnet-096bf644"
  ]
}

locals {
  service_instance_name = "${var.service_name}:${var.environment}"
  aws_name = "tf-${local.service_instance_name}"
  common_tags = {
    Name          = local.service_instance_name
    ServiceName   = var.service_name
    Environment   = var.environment
    CreatedBy     = "Terraform"
    GitRepoName   = var.git_repo_name
  }
}

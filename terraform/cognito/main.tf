terraform {
  backend "s3" {
    bucket = "remote-state-bucket"
    region = "us-west-2"
    encrypt = true
  }
}

provider "aws" {
  version = "~> 2.48"
  profile = "default"
  region = var.region
}

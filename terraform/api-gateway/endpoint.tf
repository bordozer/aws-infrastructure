resource "aws_vpc_endpoint" "execute_api" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.eu-west-3.execute-api"

  tags = local.common_tags
}

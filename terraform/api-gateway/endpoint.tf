resource "aws_vpc_endpoint" "execute_api" {
  vpc_id              = data.aws_vpc.selected.id
  service_name        = "com.amazonaws.${var.region}.execute-api"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [
    aws_security_group.endpoint.id
  ]
  subnet_ids = var.subnets

  tags = local.common_tags

  /*lifecycle {
    prevent_destroy = true
  }*/
}

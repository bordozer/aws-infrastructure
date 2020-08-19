resource "aws_security_group" "endpoint" {
  name = "${local.aws_name}-endpoint-sg"
  description = "${local.service_instance_name} API Gateway Endpoint SG"

  vpc_id = data.aws_vpc.selected.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = local.common_tags

  /*lifecycle {
    prevent_destroy = true
  }*/
}

resource "aws_security_group_rule" "with_https" {
  security_group_id   = aws_security_group.endpoint.id
  type                = "ingress"
  from_port           = "443"
  to_port             = "443"
  protocol            = "tcp"
  cidr_blocks         = [ "0.0.0.0/0" ]
  description         = "Access to private endpoint (${local.aws_name})"
}

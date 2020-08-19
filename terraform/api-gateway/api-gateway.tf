resource "aws_api_gateway_rest_api" "lambda_api_gateway" {
  name        = "${local.aws_name}-private-api-gateway"
  description = "${local.service_instance_name}: lambda API gateway"

  endpoint_configuration {
    types = ["PRIVATE"]
    vpc_endpoint_ids = [
      aws_vpc_endpoint.execute_api.id
    ]
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "execute-api:Invoke",
            "Resource": "*"
        }
    ]
}
POLICY

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}

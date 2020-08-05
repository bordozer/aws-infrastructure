resource "aws_cognito_user_pool" "pool" {
  name = "${local.aws_service_name}-user-pool"

  tags = local.common_tags
}

resource "aws_cognito_user_pool_client" "client" {
  name = "${local.aws_service_name}-user-pool-client"

  user_pool_id = aws_cognito_user_pool.pool.id
}

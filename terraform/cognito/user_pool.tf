resource "aws_cognito_user_pool" "pool" {
  name = "${local.aws_service_name}-user-pool"

  tags = local.common_tags
}

resource "aws_cognito_user_pool_client" "client" {
  name = "${local.aws_service_name}-user-pool-client"

  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_group" "user_group" {
  name         = "${local.aws_service_name}-user-group"
  user_pool_id = aws_cognito_user_pool.pool.id
  description  = "${local.service_instance_name} user group"
  precedence   = 42
  role_arn     = aws_iam_role.user_group_role.arn
}

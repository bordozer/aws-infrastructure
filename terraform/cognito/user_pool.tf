resource "aws_cognito_user_pool" "pool" {
  name                      = "${local.aws_service_name}-user-pool"
  alias_attributes          = ["email", "phone_number"]
  auto_verified_attributes  = ["email"]
  mfa_configuration         = "OFF"

  password_policy {
    minimum_length    = 6
    require_lowercase = true
    require_numbers   = true
    require_symbols   = false
    require_uppercase = true
  }

  tags = local.common_tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name                = "${local.aws_service_name}-user-pool-client"
  user_pool_id        = aws_cognito_user_pool.pool.id
  generate_secret     = true
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]
  refresh_token_validity = 29
}

/*resource "aws_cognito_user_group" "user_group" {
  name         = "${local.aws_service_name}-user-group"
  user_pool_id = aws_cognito_user_pool.pool.id
  description  = "${local.service_instance_name} user group"
  precedence   = 42
  role_arn     = aws_iam_role.user_group_role.arn
}*/

/*// https://stackoverflow.com/questions/55087715/how-to-create-a-aws-cognito-user-with-terraform
resource "null_resource" "cognito_user" {

  triggers = {
    user_pool_id = aws_cognito_user_pool.pool.id
  }

  provisioner "local-exec" {
    command = "aws cognito-idp admin-create-user --user-pool-id ${aws_cognito_user_pool.pool.id} --username ${local.aws_service_name}-user"
  }
}*/

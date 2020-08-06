resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "${local.aws_service_name}-identity-pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.client.id
    provider_name           = ""
    server_side_token_check = true
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = aws_cognito_identity_pool.main.id

  roles = {
    authenticated   = aws_iam_role.authenticated_iam_role.arn
    unauthenticated = aws_iam_role.unauthenticated_iam_role.arn
  }
}

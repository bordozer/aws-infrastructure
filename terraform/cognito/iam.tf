resource "aws_iam_role" "user_group_role" {
  name = "${local.aws_service_name}-user-group-role"

  assume_role_policy = <<EOF
 {
      "Version": "2012-10-17",
      "Statement": [
           {
                "Action": "sts:AssumeRole",
                "Principal": {
                     "Federated": "cognito-identity.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
           }
      ]
 }
EOF

  tags = local.common_tags
}

resource "aws_iam_role_policy" "get_credentials" {
  name = "${local.aws_service_name}-role-policy"
  role = aws_iam_role.user_group_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cognito-identity:GetCredentialsForIdentity"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "apigateway_and_lambda" {
  name = "${local.aws_service_name}-role-policy"
  role = aws_iam_role.user_group_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": ["apigateway.amazonaws.com","lambda.amazonaws.com"]
          },
          "Effect": "Allow",
          "Sid": ""
        }
    ]
}
EOF
}

# =====================================================
#                     Identity pool
# =====================================================
resource "aws_iam_role" "unauthenticated_iam_role" {
  name = "${local.aws_service_name}-identity-pool-unauthenticated-role"
  assume_role_policy = <<EOF
 {
      "Version": "2012-10-17",
      "Statement": [
           {
                "Action": "sts:AssumeRole",
                "Principal": {
                     "Federated": "cognito-identity.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
           }
      ]
 }
 EOF
}

resource "aws_iam_role_policy" "web_iam_unauthenticated_role_policy" {
  name = "${local.aws_service_name}-identity-pool-unauthenticated-role-policy"
  role = aws_iam_role.unauthenticated_iam_role.id
  policy = <<EOF
 {
      "Version": "2012-10-17",
      "Statement": [
           {
                "Sid": "",
                "Action": "*",
                "Effect": "Deny",
                "Resource": "*"
           }
      ]
 }
 EOF
}

resource "aws_iam_role" "authenticated_iam_role" {
  name = "${local.aws_service_name}-identity-pool-authenticated-role"
  assume_role_policy = <<EOF
 {
      "Version": "2012-10-17",
      "Statement": [
           {
                "Action": "sts:AssumeRole",
                "Principal": {
                     "Federated": "cognito-identity.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
           }
      ]
 }
 EOF
}

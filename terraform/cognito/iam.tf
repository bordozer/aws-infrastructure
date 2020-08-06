/*resource "aws_iam_role" "user_group_role" {
  name = "${local.aws_service_name}-user-group-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "*"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF

  tags = local.common_tags
}

resource "aws_iam_role_policy" "get_credentials" {
  name = "${local.aws_service_name}-get-credentials-role-policy"
  role = aws_iam_role.user_group_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cognito-identity:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "api_gateway_and_lambda" {
  name = "${local.aws_service_name}-api-gateway-and-lambda-role-policy"
  role = aws_iam_role.user_group_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}*/

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
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "*"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
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
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "*"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
}

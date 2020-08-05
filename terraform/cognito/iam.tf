resource "aws_iam_role" "user_group_role" {
  name = "${local.aws_service_name}-user-group-role"

  assume_role_policy = <<EOF
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
        },
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

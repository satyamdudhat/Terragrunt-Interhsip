resource "aws_lambda_function" "lambda_function" {
  function_name    = var.function_name
  architectures = ["x86_64"]
  package_type     = "Image"
  image_uri        = var.image_uri
  role             = aws_iam_role.lambda_execution_role.arn
}


# Lmabda Role
resource "aws_iam_role" "lambda_execution_role" {
  name               = var.iam_role_name
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

# IAM Policy for ECR Access or we can say that which wchi action can be do by lambda in ecr
resource "aws_iam_policy" "lambda_ecr_access_policy" {
  name        = var.ecr_access_policy
  description = "Policy for granting Lambda access to ECR repositories"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage"
      ],
      Resource = "*"
    }]
  })
}


resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = var.dyanmodb_access_policy
  description = "Policy for granting Lambda access to DyanmoDb Table"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:*"
            ],
            "Resource": "*"
        }
    ]
})
}


resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name        = var.cloudwatch_access_policy
  description = "Allows Lambda function to have full access to CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "logs:*"
        Resource = "*"
      }
    ]
  })
}





# # Attach ECR Access Policy to IAM Role  we attcah a role with policy
resource "aws_iam_role_policy_attachment" "Lambda_ecr_access_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_ecr_access_policy.arn
}

# Attach DynamoDb Access Policy to IAM Role  we attcah a role with Lambda Role
resource "aws_iam_role_policy_attachment" "DyanmoDb_access_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}


# Attach DynamoDb Access Policy to IAM Role  we attcah a role with Lambda Role
resource "aws_iam_role_policy_attachment" "CloudWatch_access_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}




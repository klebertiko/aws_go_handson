resource "aws_lambda_function" "ho_lambda_fn" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "ho-lambda-fn"
  handler          = "lambda"
  source_code_hash = base64sha256(data.archive_file.lambda_zip.output_path)
  runtime          = "go1.x"
  role             = aws_iam_role.ho_lambda_fn_role.arn
}

resource "aws_iam_role" "ho_lambda_fn_role" {
  name_prefix        = "ho_lambda_fn_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

variable "lambda_iam_policies_arns" {
    description = "Policies for lambda"
    type = list(string)

    default = [ "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" ]
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
    role = aws_iam_role.ho_lambda_fn_role.id
    count = length(var.lambda_iam_policies_arns)
    policy_arn = element(var.lambda_iam_policies_arns, count.index)
}



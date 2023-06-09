resource "aws_lambda_function" "lambda-project3" {
  
  filename      = "Serverless-lambda-function-main.zip"
  function_name = "serverless-api-lambda"
  role          = aws_iam_role.iam_role-project3.arn
  handler       = "exports.handler"
  runtime = "python3.7"
 
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-project3.function_name
  principal     = "events.amazonaws.com"
  qualifier     = aws_lambda_alias.yvesless_alias.name
}

resource "aws_lambda_permission" "allow_dynamodb" {
  statement_id  = "AllowExecutionFromDynamodb"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-project3.function_name
  principal     = "events.amazonaws.com"
  qualifier     = aws_lambda_alias.yvesless_alias.name
}

resource "aws_lambda_permission" "allow_apigateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda-project3.function_name
  principal     = "apigateway.amazonaws.com"
  qualifier     = aws_lambda_alias.yvesless_alias.name

}

resource "aws_lambda_alias" "yvesless_alias" {
  name             = "yvesalias"
  description      = "a sample description"
  function_name    = aws_lambda_function.lambda-project3.function_name
  function_version = "$LATEST"
}
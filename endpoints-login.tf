//==================================== Login

resource "aws_lambda_permission" "api_gw_permission_login" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_login_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.restrict_api.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "integration_login" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  integration_uri = var.lambda_login_invoke_arn

  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  connection_type    = "INTERNET"

}

resource "aws_apigatewayv2_integration" "integration_restrict_apis" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  integration_uri = var.lambda_login_invoke_arn

  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  connection_type    = "INTERNET"

  request_parameters = {
    "append:header.x-sid" = "$context.authorizer.xsid"
  }

}

resource "aws_apigatewayv2_route" "route_login" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  route_key          = "POST /login"
  target             = "integrations/${aws_apigatewayv2_integration.integration_login.id}"
}

//=====================================

//==================================== ponto

resource "aws_lambda_permission" "api_gw_permission_ponto" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_ponto_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.restrict_api.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "integration_restrict_ponto_apis" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  integration_uri = var.lambda_ponto_invoke_arn

  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  connection_type    = "INTERNET"

  request_parameters = {
    "append:header.x-sid" = "$context.authorizer.xsid"
  }

}

resource "aws_apigatewayv2_route" "route_ponto" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  route_key          = "POST /ponto/create"
  target             = "integrations/${aws_apigatewayv2_integration.integration_restrict_ponto_apis.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.authorizer.id
}

resource "aws_apigatewayv2_route" "route_ponto_read_by_date" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  route_key          = "GET /ponto/read/date"
  target             = "integrations/${aws_apigatewayv2_integration.integration_restrict_ponto_apis.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.authorizer.id
}

resource "aws_apigatewayv2_route" "route_ponto_read_by_period" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  route_key          = "GET /ponto/read/period"
  target             = "integrations/${aws_apigatewayv2_integration.integration_restrict_ponto_apis.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.authorizer.id
}
//=====================================

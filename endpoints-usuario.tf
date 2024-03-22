//==================================== Usuario

resource "aws_lambda_permission" "api_gw_permission_usuario" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_usuario_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.restrict_api.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "integration_restrict_usuario_apis" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  integration_uri = var.lambda_usuario_invoke_arn

  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  connection_type    = "INTERNET"

  request_parameters = {
    "append:header.x-sid" = "$context.authorizer.xsid"
  }

}

resource "aws_apigatewayv2_route" "route_usuario" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  route_key          = "POST /usuario/create"
  target             = "integrations/${aws_apigatewayv2_integration.integration_restrict_usuario_apis.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.authorizer.id
}

resource "aws_apigatewayv2_route" "route_get_usuario_by_username" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  route_key          = "GET /usuario/username/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.integration_restrict_usuario_apis.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.authorizer.id
}

resource "aws_apigatewayv2_route" "route_delete_usuario_by_username" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  route_key          = "DELETE /usuario/username/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.integration_restrict_usuario_apis.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.authorizer.id
}

resource "aws_apigatewayv2_route" "route_patch_usuario_by_username" {
  api_id = aws_apigatewayv2_api.restrict_api.id

  route_key          = "PATCH /usuario/username/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.integration_restrict_usuario_apis.id}"
  authorization_type = "CUSTOM"
  authorizer_id      = aws_apigatewayv2_authorizer.authorizer.id
}
//=====================================

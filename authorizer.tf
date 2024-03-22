//===================================== Authorizer
resource "aws_apigatewayv2_authorizer" "authorizer" {
  api_id                            = aws_apigatewayv2_api.restrict_api.id
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = var.lambda_authorizer_invoke_arn
  identity_sources                  = ["$request.header.Authorization"]
  name                              = "authorizer"
  authorizer_payload_format_version = "2.0"
  authorizer_result_ttl_in_seconds  = 0
}

resource "aws_lambda_permission" "api_gw_authorizer" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_authorizer_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.restrict_api.execution_arn}/*/*"
}
//=====================================
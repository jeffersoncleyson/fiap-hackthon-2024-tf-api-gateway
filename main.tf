resource "aws_apigatewayv2_api" "restrict_api" {
  name          = var.api_gateway_name
  protocol_type = "HTTP"

  tags = {
    App = var.application_name
  }
}

//==================================== Logs
resource "aws_cloudwatch_log_group" "api_gw_logs" {
  name              = "/aws/api_gw/${aws_apigatewayv2_api.restrict_api.name}"
  retention_in_days = 3

  tags = {
    App  = var.application_name
  }
}
//====================================





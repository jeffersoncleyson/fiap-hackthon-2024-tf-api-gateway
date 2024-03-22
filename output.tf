############################################### Restrict API Gateway [API Gateway] Outputs

output "base_url_api_gw_invoke_url" {
  description = "Base URL for API Gateway Stage."

  value = aws_apigatewayv2_stage.api_stage.invoke_url
}

###############################################
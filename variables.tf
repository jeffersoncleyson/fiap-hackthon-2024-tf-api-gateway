# Input variable definitions

variable "application_name" {
  description = "Application name"
  type        = string
}

variable "api_gateway_name" {
  description = "API Gateway name"
  type        = string
}

variable "stage_name" {
  description = "Stage name"
  type        = string
}

variable "lambda_login_invoke_arn" {
  description = "Lambda Invoke ARN"
  type        = string
}

variable "lambda_login_name" {
  description = "Lambda Name"
  type        = string
}

variable "lambda_authorizer_name" {
  description = "Lambda Authorizer Name"
  type        = string
}

variable "lambda_authorizer_invoke_arn" {
  description = "Lambda Authorizer Invoke ARN"
  type        = string
}

variable "lambda_usuario_name" {
  description = "Lambda Usuario Name"
  type        = string
}

variable "lambda_usuario_invoke_arn" {
  description = "Lambda Usuario Invoke ARN"
  type        = string
}

variable "lambda_ponto_name" {
  description = "Lambda Ponto Name"
  type        = string
}

variable "lambda_ponto_invoke_arn" {
  description = "Lambda Ponto Invoke ARN"
  type        = string
}

variable "lambda_relatorio_name" {
  description = "Lambda Relatorio Name"
  type        = string
}

variable "lambda_relatorio_invoke_arn" {
  description = "Lambda Relatorio Invoke ARN"
  type        = string
}
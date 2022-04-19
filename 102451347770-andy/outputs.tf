# output "instance_id" {
#   description = "instance id "
#   value       = aws_instance.app_server.id
# }

output "lambda_function_arn" {
  description = "function arn"
  value       = module.lambda_function.lambda_function_arn
}
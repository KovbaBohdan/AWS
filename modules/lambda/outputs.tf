# output "get_all_authors_arn" {
#   value = aws_lambda_function.lambda_get_all_authors.arn
# }
# output "get_all_authors_invoke_arn" {
#   value = aws_lambda_function.lambda_get_all_authors.invoke_arn
# }

# output "get_all_courses_arn" {
#   value = aws_lambda_function.lambda_get_all_courses.arn
# }
# output "get_all_courses_invoke_arn" {
#   value = aws_lambda_function.lambda_get_all_courses.invoke_arn
# }
output "get_all_authors_arn" {
    value = module.lambda_get_all_authors.lambda_function_arn
}

output "lambda_courses_invoke_arn"{
    value = module.lambda_get_all_courses.lambda_function_invoke_arn
}

output "lambda_get_all_authors_invoke_arn"{
    value = module.lambda_get_all_authors.lambda_function_invoke_arn
}

# output "lambda_save_course_invoke_arn"{
#     value = module.lambda_save_courses.lambda_function_invoke_arn
# }



# output "lambda_save_courses_function_name" {
#   value = module.lambda_save_courses.lambda_function_name
# }

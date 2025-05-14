output "get_all_authors_arn" {
    value = module.lambda_get_all_authors.lambda_function_arn
}

output "lambda_get_all_authors_invoke_arn"{
    value = module.lambda_get_all_authors.lambda_function_invoke_arn
}

output "get_all_courses_arn" {
    value = module.lambda_get_all_courses.lambda_function_arn
}

output "lambda_courses_invoke_arn"{
    value = module.lambda_get_all_courses.lambda_function_invoke_arn
}

output "lambda_save_courses_arn" {
    value = module.lambda_save_courses.lambda_function_arn
}

output "lambda_save_courses_invoke_arn"{
    value = module.lambda_save_courses.lambda_function_invoke_arn
}

output "lambda_get_course_arn" {
    value = module.lambda_get_course.lambda_function_arn
}

output "lambda_get_course_invoke_arn"{
    value = module.lambda_get_course.lambda_function_invoke_arn
}

output "lambda_delete_course_arn" {
    value = module.lambda_delete_course.lambda_function_arn
}

output "lambda_delete_course_invoke_arn"{
    value = module.lambda_delete_course.lambda_function_invoke_arn
}

output "lambda_update_cource_arn" {
    value = module.lambda_update_cource.lambda_function_arn
}

output "lambda_update_cource_invoke_arn"{
    value = module.lambda_update_cource.lambda_function_invoke_arn
}
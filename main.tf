module "table_cources" {
  source = "./modules/dynamodb"
  context = module.label.context
  name = "cources"
}

module "table_authors" {
  source = "./modules/dynamodb"
  context = module.label.context
  name = "authors"
}

module "lambda_functions" {
  source = "./modules/lambda"
  context = module.label.context
  courses_table = module.table_cources.table_name
  authors_table = module.table_authors.table_name
  courses_table_arn = module.table_cources.table_arn
  authors_table_arn = module.table_authors.table_arn
  aws_api_gateway_rest_api_execution_arn = aws_api_gateway_rest_api.this.execution_arn
}


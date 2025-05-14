module "label" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.25.0"

  context = var.context
  name = var.name
}

module "label_get_all_authors" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.25.0"

  context = var.context
  name = "get-all-authors"
}

module "label_get_all_courses" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.25.0"

  context = var.context
  name = "get-all-courses"
}

module "label_save_course" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.25.0"

  context = var.context
  name = "save-course"
}

module "label_update_course" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.25.0"

  context = var.context
  name = "update-course"
}

module "label_get_course" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.25.0"

  context = var.context
  name = "get-course"
}

module "label_delete_course" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.25.0"

  context = var.context
  name = "delete-course"
}

module "lambda_get_all_authors" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.20.1"
  function_name = module.label_get_all_authors.id
  description   = "My awesome lambda function"
  handler       = "index.handler"
  runtime       = "nodejs16.x"

  source_path = "${path.module}/src/get-all-authors"

  environment_variables = {
    TABLE_NAME = var.authors_table
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect    = "Allow",
      actions   = ["dynamodb:Scan"],
      resources =["${var.authors_table_arn}"],
    }
  }

  allowed_triggers = {
    APIGatewayAny = {
      service    = "apigateway"
      source_arn = "${var.aws_api_gateway_rest_api_execution_arn}/*/*/*"
    }
  }
  publish = true
  create_current_version_allowed_triggers = false
  
  tags = module.label.tags
}

module "lambda_get_all_courses" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.20.1"
  function_name = module.label_get_all_courses.id
  description   = "My awesome lambda function"
  handler       = "index.handler"
  runtime       = "nodejs16.x"

  source_path = "${path.module}/src/get-all-courses"

  environment_variables = {
    TABLE_NAME = var.courses_table
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect    = "Allow",
      actions   = ["dynamodb:Scan"],
      resources =["${var.courses_table_arn}"],
    }
  }

  allowed_triggers = {
    APIGatewayAny = {
      service    = "apigateway"
      source_arn = "${var.aws_api_gateway_rest_api_execution_arn}/*/*/*"
    }
  }
  publish                                 = true
  create_current_version_allowed_triggers = false
  
  tags = module.label.tags
}

module "lambda_save_courses" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.20.1"
  function_name = module.label_save_course.id
  description   = "My awesome lambda function"
  handler       = "index.handler"
  runtime       = "nodejs16.x"

  source_path = "${path.module}/src/save-course"

  environment_variables = {
    TABLE_COURSES = var.courses_table
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect    = "Allow",
      actions   = ["dynamodb:PutItem"],
      resources =["${var.courses_table_arn}"],
    }
  }
  
  tags = module.label.tags
}

module "lambda_update_cource" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.20.1"
  function_name = module.label_update_course.id
  description   = "My awesome lambda function"
  handler       = "index.handler"
  runtime       = "nodejs16.x"

  source_path = "${path.module}/src/update-course"

  environment_variables = {
    TABLE_NAME = var.courses_table
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect    = "Allow",
      actions   = ["dynamodb:PutItem"],
      resources =["${var.courses_table_arn}"],
    }
  }
  
  tags = module.label.tags
}

module "lambda_get_course" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.20.1"
  function_name = module.label_get_course.id
  description   = "My awesome lambda function"
  handler       = "index.handler"
  runtime       = "nodejs16.x"

  source_path = "${path.module}/src/get-course"

  environment_variables = {
    TABLE_NAME = var.courses_table
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect    = "Allow",
      actions   = ["dynamodb:GetItem"],
      resources =["${var.courses_table_arn}"],
    }
  }
  
  tags = module.label.tags
}

module "lambda_delete_course" {
  source = "terraform-aws-modules/lambda/aws"
  version = "7.20.1"
  function_name = module.label_delete_course.id
  description   = "My awesome lambda function"
  handler       = "index.handler"
  runtime       = "nodejs16.x"

  source_path = "${path.module}/src/delete-course"

  environment_variables = {
    TABLE_NAME = var.courses_table
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect    = "Allow",
      actions   = ["dynamodb:DeleteItem"],
      resources =["${var.courses_table_arn}"],
    }
  }
  
  tags = module.label.tags
}
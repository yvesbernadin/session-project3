resource "aws_api_gateway_rest_api" "rest_api-project3" {
  name = "api-project3"
}
#  Health Resource

resource "aws_api_gateway_resource" "Health-project3" {
  parent_id   = aws_api_gateway_rest_api.rest_api-project3.root_resource_id
  path_part   = "health"
  rest_api_id = aws_api_gateway_rest_api.rest_api-project3.id
}

resource "aws_api_gateway_method" "method_health-project3" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.Health-project3.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
}

resource "aws_api_gateway_method" "method1_health-project3" {
  authorization = "NONE"
  http_method   = "OPTIONS"
  resource_id   = aws_api_gateway_resource.Health-project3.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
}

resource "aws_api_gateway_integration" "integration_health-project3" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id             = aws_api_gateway_resource.Health-project3.id
  http_method             = aws_api_gateway_method.method_health-project3.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-project3.invoke_arn
}

resource "aws_api_gateway_integration" "integration1_health-project3" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id             = aws_api_gateway_resource.Health-project3.id
  http_method             = aws_api_gateway_method.method1_health-project3.http_method
  integration_http_method = "OPTIONS"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-project3.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment_health-project3" {
  rest_api_id = aws_api_gateway_rest_api.rest_api-project3.id

  triggers = {
    
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.Health-project3.id,
      aws_api_gateway_method.method_health-project3.id,
      aws_api_gateway_method.method1_health-project3.id,
      aws_api_gateway_integration.integration_health-project3.id,
      aws_api_gateway_integration.integration1_health-project3.id
    ]))
  }

  lifecycle {
    create_before_destroy = false
  }
}


# user resource

resource "aws_api_gateway_resource" "user-project3" {
  path_part   = "user"
  parent_id   = aws_api_gateway_rest_api.rest_api-project3.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.rest_api-project3.id
}

resource "aws_api_gateway_method" "user_method-project3" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id   = aws_api_gateway_resource.user-project3.id
  http_method = "GET"  
  #http_method   = ["OPTIONS", "PUT", "GET", "DELETE"]
  authorization = "NONE"
}

resource "aws_api_gateway_method" "user_method1-project3" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id   = aws_api_gateway_resource.user-project3.id
  http_method = "PUT"  
  #http_method   = ["OPTIONS", "PUT", "GET", "DELETE"]
  authorization = "NONE"
}

resource "aws_api_gateway_method" "user_method2-project3" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id   = aws_api_gateway_resource.user-project3.id
  http_method = "DELETE"  
  #http_method   = ["OPTIONS", "PUT", "GET", "DELETE"]
  authorization = "NONE"
}

resource "aws_api_gateway_method" "user_method3-project3" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id   = aws_api_gateway_resource.user-project3.id
  http_method = "POST"  
  #http_method   = ["OPTIONS", "PUT", "GET", "DELETE"]
  authorization = "NONE"
}

resource "aws_api_gateway_method" "user_method4-project3" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id   = aws_api_gateway_resource.user-project3.id
  http_method = "OPTIONS"  
  #http_method   = ["OPTIONS", "PUT", "GET", "DELETE"]
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "user_integration-project3" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id             = aws_api_gateway_resource.user-project3.id
  http_method             = aws_api_gateway_method.user_method-project3.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-project3.invoke_arn
}

resource "aws_api_gateway_integration" "user_integration1-project3" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id             = aws_api_gateway_resource.user-project3.id
  http_method             = aws_api_gateway_method.user_method1-project3.http_method
  integration_http_method = "PUT"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-project3.invoke_arn
}

resource "aws_api_gateway_integration" "user_integration2-project3" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id             = aws_api_gateway_resource.user-project3.id
  http_method             = aws_api_gateway_method.user_method2-project3.http_method
  integration_http_method = "DELETE"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-project3.invoke_arn
} 

resource "aws_api_gateway_integration" "user_integration3-project3" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id             = aws_api_gateway_resource.user-project3.id
  http_method             = aws_api_gateway_method.user_method3-project3.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-project3.invoke_arn
} 

resource "aws_api_gateway_integration" "user_integration4-project3" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id             = aws_api_gateway_resource.user-project3.id
  http_method             = aws_api_gateway_method.user_method4-project3.http_method
  integration_http_method = "OPTIONS"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-project3.invoke_arn
} 

resource "aws_api_gateway_deployment" "user_deployment-project3" {
  rest_api_id = aws_api_gateway_rest_api.rest_api-project3.id

  triggers = {
   
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.user-project3.id,
      aws_api_gateway_method.user_method1-project3.id,
      aws_api_gateway_method.user_method2-project3.id,
      aws_api_gateway_method.user_method3-project3.id,
      aws_api_gateway_method.user_method4-project3.id,
      aws_api_gateway_method.user_method-project3.id,
      aws_api_gateway_integration.user_integration-project3.id,
      aws_api_gateway_integration.user_integration1-project3.id,
      aws_api_gateway_integration.user_integration4-project3.id,
      aws_api_gateway_integration.user_integration2-project3.id,
      aws_api_gateway_integration.user_integration3-project3.id
      
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_api_gateway_method_response" "user_response_200" {
  rest_api_id = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id = aws_api_gateway_resource.user-project3.id
  http_method = aws_api_gateway_method.user_method-project3.http_method
  status_code = "200"

}
resource "aws_api_gateway_stage" "stage-users" {
  deployment_id = aws_api_gateway_deployment.users_deployment-project3.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
  stage_name    = "register"
}

resource "aws_api_gateway_method_settings" "example" {
  rest_api_id = aws_api_gateway_rest_api.rest_api-project3.id
  stage_name  = aws_api_gateway_stage.stage-users.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

/*
resource "aws_api_gateway_integration_response" "IntegrationResponse-project3" {
  rest_api_id = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id = aws_api_gateway_resource.user-project3.id
  http_method = aws_api_gateway_method.user_method-project3.http_method
  status_code = aws_api_gateway_method_response.user_response_200.status_code

  
}
*/
# USERS RESOURCE

resource "aws_api_gateway_resource" "users-project3" {
  path_part   = "users"
  parent_id   = aws_api_gateway_rest_api.rest_api-project3.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.rest_api-project3.id
}

resource "aws_api_gateway_method" "users_method-project3" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id   = aws_api_gateway_resource.users-project3.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "users_method1-project3" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id   = aws_api_gateway_resource.users-project3.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "users_integration-project3" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id             = aws_api_gateway_resource.users-project3.id
  http_method             = aws_api_gateway_method.users_method-project3.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-project3.invoke_arn
}

resource "aws_api_gateway_integration" "users_integration1-project3" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api-project3.id
  resource_id             = aws_api_gateway_resource.users-project3.id
  http_method             = aws_api_gateway_method.users_method1-project3.http_method
  integration_http_method = "OPTIONS"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda-project3.invoke_arn
}

resource "aws_api_gateway_deployment" "users_deployment-project3" {
  rest_api_id = aws_api_gateway_rest_api.rest_api-project3.id

  triggers = {
   
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.users-project3.id,
      aws_api_gateway_method.users_method-project3.id,
      aws_api_gateway_method.users_method1-project3.id,
      aws_api_gateway_integration.users_integration-project3.id,
      aws_api_gateway_integration.users_integration1-project3.id
    ]))
  }

  lifecycle {
    create_before_destroy = false
  }
}


#---------------------------------------------Status Resource Code--------------------------------------------------------------------------------------------
resource "aws_api_gateway_rest_api" "employeeinfo" {
  name        = var.api_name
}

resource "aws_api_gateway_resource" "status_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  parent_id   = "${aws_api_gateway_rest_api.employeeinfo.root_resource_id}"
  path_part   = element(var.api_path_name,0)
}


resource "aws_api_gateway_method" "status_method" {
  count = length(var.status_http_methods)
  authorization = "NONE"
  http_method   = var.status_http_methods[count.index]
  rest_api_id   = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.status_resource.id}"
}

resource "aws_api_gateway_integration" "status_integration" {
  count = length(var.status_http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.status_resource.id}"
  http_method = "${aws_api_gateway_method.status_method[count.index].http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_uri
}

# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda_status_permission" {
  count = length(var.status_http_methods)
  statement_id  = "AllowExecutionFromAPIGateway_status_${count.index}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.employeeinfo.execution_arn}/*/${aws_api_gateway_method.status_method[count.index].http_method}${aws_api_gateway_resource.status_resource.path}"
}


# ---------------------CoRS Integration Status
resource "aws_api_gateway_method_response" "status_method_response" {
  count = length(var.status_http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.status_resource.id}"
  http_method = "${aws_api_gateway_method.status_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "status_integration_response" {
  count = length(var.status_http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.status_resource.id}"
  http_method = "${aws_api_gateway_method.status_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.status_integration]
}






# ---------------------------------------------------Employee Resource------------------------------------------------------------------------------


resource "aws_api_gateway_resource" "employee_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  parent_id   = "${aws_api_gateway_rest_api.employeeinfo.root_resource_id}"
  path_part   = element(var.api_path_name,1)
}


resource "aws_api_gateway_method" "employee_method" {
  count = length(var.employee_http_methods)
  authorization = "NONE"
  http_method   = var.employee_http_methods[count.index]
  rest_api_id   = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employee_resource.id}"
}

resource "aws_api_gateway_integration" "employee_integration" {
  count = length(var.employee_http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employee_resource.id}"
  http_method = "${aws_api_gateway_method.employee_method[count.index].http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_uri
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda_employee_permission" {
  count = length(var.employee_http_methods)
  statement_id  = "AllowExecutionFromAPIGateway_employee_${count.index}" 
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.employeeinfo.execution_arn}/*/${aws_api_gateway_method.employee_method[count.index].http_method}${aws_api_gateway_resource.employee_resource.path}"
}


# ---------------------CoRS Integration Status
resource "aws_api_gateway_method_response" "employee_method_response" {
  count = length(var.employee_http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employee_resource.id}"
  http_method = "${aws_api_gateway_method.employee_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "employee_integration_response" {
  count = length(var.employee_http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employee_resource.id}"
  http_method = "${aws_api_gateway_method.employee_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.employee_integration]
}














# ---------------------------------------------------Employees Resource------------------------------------------------------------------------------


resource "aws_api_gateway_resource" "employees_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  parent_id   = "${aws_api_gateway_rest_api.employeeinfo.root_resource_id}"
  path_part   = element(var.api_path_name,2)
}


resource "aws_api_gateway_method" "employees_method" {
  count = length(var.employees_http_methods)
  authorization = "NONE"
  http_method   = var.employees_http_methods[count.index]
  rest_api_id   = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employees_resource.id}"
}

resource "aws_api_gateway_integration" "employees_integration" {
  count = length(var.employees_http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employees_resource.id}"
  http_method = "${aws_api_gateway_method.employees_method[count.index].http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_uri
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda_employees_permission" {
  count = length(var.employees_http_methods)
  statement_id  = "AllowExecutionFromAPIGateway_employees_${count.index}" 
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.employeeinfo.execution_arn}/*/${aws_api_gateway_method.employees_method[count.index].http_method}${aws_api_gateway_resource.employees_resource.path}"
}


# ---------------------CoRS Integration Status
resource "aws_api_gateway_method_response" "employees_method_response" {
  count = length(var.employees_http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employees_resource.id}"
  http_method = "${aws_api_gateway_method.employees_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "employees_integration_response" {
  count = length(var.employees_http_methods)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employees_resource.id}"
  http_method = "${aws_api_gateway_method.employees_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.employees_integration]
}



















#-------------------------------------------------------- Deployement Cource

resource "aws_api_gateway_deployment" "combined_deployment" {
  rest_api_id = aws_api_gateway_rest_api.employeeinfo.id

  triggers = {
    redeployment = sha1(jsonencode(concat(aws_api_gateway_method.status_method[*].id, aws_api_gateway_method.employee_method[*].id, aws_api_gateway_method.employees_method[*].id)))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.status_integration,
    aws_api_gateway_integration.employee_integration,
    aws_api_gateway_integration.employees_integration

  ]
}



resource "aws_api_gateway_stage" "Dev_Stage" {
  deployment_id = aws_api_gateway_deployment.combined_deployment.id
  rest_api_id = aws_api_gateway_rest_api.employeeinfo.id
  stage_name = "dev"
}





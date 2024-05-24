#---------------------------------------------Status Resource Code--------------------------------------------------------------------------------------------
resource "aws_api_gateway_rest_api" "employeeinfo" {
  name        = var.api_name
}

resource "aws_api_gateway_resource" "status" {
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  parent_id   = "${aws_api_gateway_rest_api.employeeinfo.root_resource_id}"
  path_part   = element(var.api_path_name,0)
}


resource "aws_api_gateway_method" "status_method" {
  count = length(var.http_methods_status)
  authorization = "NONE"
  http_method   = var.http_methods_status[count.index]
  rest_api_id   = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.status.id}"
}

resource "aws_api_gateway_integration" "status_integration" {
  count = length(var.http_methods_status)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.status.id}"
  http_method = "${aws_api_gateway_method.status_method[count.index].http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.uri
}

# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda_status" {
  count = length(var.http_methods_status)
  statement_id  = "AllowExecutionFromAPIGateway_status_${count.index}"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.employeeinfo.execution_arn}/*/${aws_api_gateway_method.status_method[count.index].http_method}${aws_api_gateway_resource.status.path}"
}


# ---------------------CoRS Integration Status
resource "aws_api_gateway_method_response" "method_response_status" {
  count = length(var.http_methods_status)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.status.id}"
  http_method = "${aws_api_gateway_method.status_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "integration_response_status" {
  count = length(var.http_methods_status)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.status.id}"
  http_method = "${aws_api_gateway_method.status_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  depends_on = [aws_api_gateway_integration.status_integration]
}






# ---------------------------------------------------Employee Resource------------------------------------------------------------------------------


resource "aws_api_gateway_resource" "employee" {
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  parent_id   = "${aws_api_gateway_rest_api.employeeinfo.root_resource_id}"
  path_part   = element(var.api_path_name,1)
}


resource "aws_api_gateway_method" "employee_method" {
  count = length(var.http_methods_employee)
  authorization = "NONE"
  http_method   = var.http_methods_employee[count.index]
  rest_api_id   = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employee.id}"
}

resource "aws_api_gateway_integration" "employee_integration" {
  count = length(var.http_methods_employee)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employee.id}"
  http_method = "${aws_api_gateway_method.employee_method[count.index].http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.uri
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda_employee" {
  count = length(var.http_methods_employee)
  statement_id  = "AllowExecutionFromAPIGateway_employee_${count.index}" 
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.employeeinfo.execution_arn}/*/${aws_api_gateway_method.employee_method[count.index].http_method}${aws_api_gateway_resource.employee.path}"
}


# ---------------------CoRS Integration Status
resource "aws_api_gateway_method_response" "method_response_employee" {
  count = length(var.http_methods_employee)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employee.id}"
  http_method = "${aws_api_gateway_method.employee_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "integration_response_employee" {
  count = length(var.http_methods_employee)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employee.id}"
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
  count = length(var.http_methods_employees)
  authorization = "NONE"
  http_method   = var.http_methods_employees[count.index]
  rest_api_id   = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employees_resource.id}"
}

resource "aws_api_gateway_integration" "employees_integration" {
  count = length(var.http_methods_employees)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employees_resource.id}"
  http_method = "${aws_api_gateway_method.employees_method[count.index].http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.uri
}


# Lambda Permission Code
resource "aws_lambda_permission" "apigw_lambda_employees" {
  count = length(var.http_methods_employees)
  statement_id  = "AllowExecutionFromAPIGateway_employees_${count.index}" 
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.employeeinfo.execution_arn}/*/${aws_api_gateway_method.employees_method[count.index].http_method}${aws_api_gateway_resource.employees_resource.path}"
}


# ---------------------CoRS Integration Status
resource "aws_api_gateway_method_response" "method_response_employees" {
  count = length(var.http_methods_employees)
  rest_api_id = "${aws_api_gateway_rest_api.employeeinfo.id}"
  resource_id   = "${aws_api_gateway_resource.employees_resource.id}"
  http_method = "${aws_api_gateway_method.employees_method[count.index].http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "integration_response_employees" {
  count = length(var.http_methods_employees)
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





//
// gateway
//
#? 참고 / https://github.com/terraform-aws-modules/terraform-aws-apigateway-v2/blob/master/examples/complete-http/main.tf
module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "${var.name}-HTTP-Gateway"
  description   = "${var.name} HTTP API Gateway"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["*"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  domain_name                 = "${var.name}.${var.domain}"
  domain_name_certificate_arn = data.aws_acm_certificate.this.arn

  default_stage_access_log_destination_arn = aws_cloudwatch_log_group.this.arn
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  default_route_settings = {
    detailed_metrics_enabled = true
    throttling_burst_limit   = 100
    throttling_rate_limit    = 100
  }

  integrations = {
    "$default" = {
      lambda_arn = module.lambda_function.lambda_function_arn
    }
  }

  tags = {
    Name = var.name
  }
}

//
// route53
//
data "aws_route53_zone" "this" {
  name = var.domain
}
# TODO. 이거 활용 가능한지 테스트
data "aws_acm_certificate" "this" {
  domain   = "*.${var.domain}"
  statuses = ["ISSUED"]
}
resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "${var.name}.${var.domain}"
  type    = "A"

  alias {
    name                   = module.api_gateway.apigatewayv2_domain_name_configuration[0].target_domain_name
    zone_id                = module.api_gateway.apigatewayv2_domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}

//
// lambda
//
# TODO. local-exec 활용하면 pre-build 도 괜찮게 만들 수 있을듯 하다. / 크게 필요는 없을듯 해서 보류
# resource "null_resource" "download_package" {
#   triggers = {
#     downloaded = local.downloaded
#   }

#   provisioner "local-exec" {
#     command = "curl -L -o ${local.downloaded} ${local.package_url}"
#   }
# }
#? 참고 / https://github.com/terraform-aws-modules/terraform-aws-lambda
module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 3.0"

  function_name = "${var.name}-lambda"
  description   = "${var.name} lambda function"
  handler       = "main"
  runtime       = "go1.x"
  # filename = "lambda.zip"
  # source_code_hash = sha256(filebase64("${path.module}/build/lambda.zip"))

  create_package = false
  local_existing_package = "${path.module}/build/lambda.zip"
  # source_path = "${path.module}/build/lambda.zip"

  publish = true


  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*"
    }
  }
}

//
// cloud watch
//
resource "aws_cloudwatch_log_group" "this" {
  name = var.name
  retention_in_days = 1
}

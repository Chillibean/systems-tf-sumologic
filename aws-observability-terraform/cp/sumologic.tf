
module "collection-module" {
  source                    = "../source-module//"
  aws_account_alias         = "aws-observability-${var.envlabel}"
  sumologic_organization_id = local.sumologiccreds["organization_id"]
  access_id                 = local.sumologiccreds["access_id"]
  access_key                = local.sumologiccreds["access_key"]
  environment               = "eu"
  # ALB logs
  collect_elb_logs = false
  # CLB logs
  collect_classic_lb_logs = false
  # CW logs 
  collect_cloudwatch_logs = "None"
  # Enable Collection of Cloudtrail logs
  collect_cloudtrail_logs = true
  cloudtrail_source_details = {
    source_name     = "CloudTrail Logs ${var.aws_region}"
    source_category = "aws/observability/cloudtrail/logs"
    description     = "This source is created using Sumo Logic terraform AWS Observability module to collect AWS cloudtrail logs."
    bucket_details = {
      create_bucket        = true
      bucket_name          = "${var.aws_region}-aws-observability-logs-${var.envlabel}"
      path_expression      = "AWSLogs/*/CloudTrail/*/*"
      force_destroy_bucket = true
    }
    fields = {}
  }
  # Collect CW metrics
  collect_cloudwatch_metrics = "CloudWatch Metrics Source"
  cloudwatch_metrics_source_details = {
    "bucket_details" : {
      "bucket_name" : "${var.aws_region}-aws-observability-${var.envlabel}"
      "create_bucket" : true
      "force_destroy_bucket" : true
    },
    "description" : "This source is created using Sumo Logic terraform AWS Observability module to collect AWS Cloudwatch metrics.",
    "fields" : {},
    "limit_to_namespaces" : [
      "AWS/ApiGateway",
      "AWS/ApplicationELB",
      "AWS/DynamoDB",
      "AWS/EBS",
      "AWS/EC2",
      "AWS/EC2Spot",
      "AWS/ELB",
      "AWS/KMS",
      "AWS/Lambda",
      "AWS/Logs",
      "AWS/NATGateway",
      "AWS/NetworkELB",
      "AWS/RDS",
      "AWS/Route53",
      "AWS/S3",
      "AWS/SQS"
    ],
    "source_category" : "aws/observability/cloudwatch/metrics/${var.aws_region}",
    "source_name" : "CloudWatch Metrics ${var.aws_region}"
  }
  # RCE
  collect_root_cause_data = "None"
}


module "sumo-module" {
  source                   = "../app-modules//"
  access_id                = local.sumologiccreds["access_id"]
  access_key               = local.sumologiccreds["access_key"]
  environment              = "eu"
  json_file_directory_path = join("", [abspath("../..") ])
  folder_installation_location = "Admin Recommended Folder"
  folder_share_with_org        = true
  sumologic_organization_id    = local.sumologiccreds["organization_id"]
  apigateway_monitors_disabled = false
  alb_monitors_disabled        = false
  dynamodb_monitors_disabled   = false
  ec2metrics_monitors_disabled = false
  elb_monitors_disabled        = false
  lambda_monitors_disabled     = false
  nlb_monitors_disabled        = false
  ecs_monitors_disabled        = true
  rds_monitors_disabled        = false
  apps_folder_name             = "AWS ${var.envlabel}"
  monitors_folder_name         = "AWS Observability Monitors - ${var.envlabel}"
  awso_hierachy_name           = "AWS Observability - ${var.envlabel}"
}

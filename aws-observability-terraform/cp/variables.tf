data "aws_secretsmanager_secret" "sumologic" {
  provider = aws.root
  name = "sumologic"
}
data "aws_secretsmanager_secret_version" "sumologic" {
  provider = aws.root
  secret_id = data.aws_secretsmanager_secret.sumologic.id
}

locals {
  sumologiccreds=jsondecode(data.aws_secretsmanager_secret_version.sumologic.secret_string)
}

variable "envlabel" {
  description = "Environment name used in the AWS account to provision the resources"
  type        = string
}
variable "aws_region" {
  description = "AWS Region the infrastructure resources will be provisioned"
  type        = string
}


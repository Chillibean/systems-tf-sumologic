#Sumo Logic SDO solution - This files has code to create FER's in Sumo Logic.

resource "sumologic_field_extraction_rule" "github_pr_fer" {
  count            = "${var.install_github}" == "fer" || "${var.install_github}" == "collection" || "${var.install_github}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.github,restapi_object.github_field]
  name             = "SDO - Github Pull Request"
  scope            = "_sourceCategory=${var.github_sc} ${var.github_pull_request_fer_scope}"
  parse_expression = var.github_pull_request_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "jenkins_build_fer" {
  count            = "${var.install_jenkins}" == "fer" || "${var.install_jenkins}" == "collection" || "${var.install_jenkins}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.jenkins]
  name             = "SDO - Jenkins Build"
  scope            = "_sourceCategory=${var.jenkins_sc} ${var.jenkins_build_fer_scope}"
  parse_expression = var.jenkins_build_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "jenkins_deploy_fer" {
  count            = "${var.install_jenkins}" == "fer" || "${var.install_jenkins}" == "collection" || "${var.install_jenkins}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.jenkins]
  name             = "SDO - Jenkins Deploy"
  scope            = "_sourceCategory=${var.jenkins_sc} ${var.jenkins_deploy_fer_scope}"
  parse_expression = var.jenkins_deploy_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "jenkins_pipeline_stages_fer" {
  count            = "${var.install_jenkins}" == "fer" || "${var.install_jenkins}" == "collection" || "${var.install_jenkins}" == "all" ? 1 : 0
  name             = "SDO - Jenkins Pipeline Stages"
  scope            = "_sourceCategory=${var.jenkins_sc} ${var.jenkins_build_status_fer_scope}"
  parse_expression = var.jenkins_build_status_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "opsgenie_alerts_fer" {
  count            = "${var.install_opsgenie}" == "fer" || "${var.install_opsgenie}" == "collection" || "${var.install_opsgenie}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.opsgenie]
  name             = "SDO - Opsgenie Alerts"
  scope            = "_sourceCategory=${var.opsgenie_sc} ${var.opsgenie_alerts_fer_scope}"
  parse_expression = var.opsgenie_alerts_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "bitbucket_pr_fer" {
  count            = "${var.install_bitbucket_cloud}" == "fer" || "${var.install_bitbucket_cloud}" == "collection" || "${var.install_bitbucket_cloud}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.bitbucket_cloud,restapi_object.bitbucket_field]
  name             = "SDO - Bitbucket Pull Request"
  scope            = "_sourceCategory=${var.bitbucket_sc} ${var.bitbucket_pull_request_fer_scope}"
  parse_expression = var.bitbucket_pull_request_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "bitbucket_build_fer" {
  count            = "${var.install_bitbucket_cloud}" == "fer" || "${var.install_bitbucket_cloud}" == "collection" || "${var.install_bitbucket_cloud}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.bitbucket_cloud,restapi_object.bitbucket_field]
  name             = "SDO - Bitbucket Build"
  scope            = "_sourceCategory=${var.bitbucket_sc} ${var.bitbucket_build_fer_scope}"
  parse_expression = var.bitbucket_build_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "bitbucket_deploy_fer" {
  count            = "${var.install_bitbucket_cloud}" == "fer" || "${var.install_bitbucket_cloud}" == "collection" || "${var.install_bitbucket_cloud}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.bitbucket_cloud,restapi_object.bitbucket_field]
  name             = "SDO - Bitbucket Deploy"
  scope            = "_sourceCategory=${var.bitbucket_sc} ${var.bitbucket_deploy_fer_scope}"
  parse_expression = var.bitbucket_deploy_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "jira_issues_fer" {
  count            = "${var.install_jira_cloud}" == "fer" || "${var.install_jira_cloud}" == "collection" || "${var.install_jira_cloud}" == "all" || "${var.install_jira_server}" == "fer" || "${var.install_jira_server}" == "collection" || "${var.install_jira_server}" == "all" ? 1 : 0
  name             = "SDO - Jira Issues"
  scope            = "_sourceCategory=${var.jira_cloud_sc} or _sourceCategory=${var.jira_server_sc} ${var.jira_issues_fer_scope}"
  parse_expression = var.jira_issues_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "pagerduty_alerts_fer" {
  count            = "${var.install_pagerduty}" == "fer" || "${var.install_pagerduty}" == "collection" || "${var.install_pagerduty}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.pagerduty]
  name             = "SDO - Pagerduty Alerts"
  scope            = "_sourceCategory=${var.pagerduty_sc} ${var.pagerduty_alerts_fer_scope}"
  parse_expression = var.pagerduty_alerts_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "gitlab_pr_fer" {
  count            = "${var.install_gitlab}" == "fer" || "${var.install_gitlab}" == "collection" || "${var.install_gitlab}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.gitlab,restapi_object.gitlab_field]
  name             = "SDO - Gitlab Pull Request"
  scope            = "_sourceCategory=${var.gitlab_sc} ${var.gitlab_pull_request_fer_scope}"
  parse_expression = var.gitlab_pull_request_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "gitlab_build_fer" {
  count            = "${var.install_gitlab}" == "fer" || "${var.install_gitlab}" == "collection" || "${var.install_gitlab}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.gitlab,restapi_object.gitlab_field]
  name             = "SDO - Gitlab Build"
  scope            = "_sourceCategory=${var.gitlab_sc} ${var.gitlab_build_request_fer_scope}"
  #parse_expression = var.gitlab_build_request_fer_parse
  parse_expression = replace(var.gitlab_build_request_fer_parse,"Gitlab_Build_Job_Name",var.gitlab_build_jobname)
  enabled          = true
}

resource "sumologic_field_extraction_rule" "gitlab_deploy_fer" {
  count            = "${var.install_gitlab}" == "fer" || "${var.install_gitlab}" == "collection" || "${var.install_gitlab}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.gitlab,restapi_object.gitlab_field]
  name             = "SDO - Gitlab Deploy"
  scope            = "_sourceCategory=${var.gitlab_sc} ${var.gitlab_deploy_request_fer_scope}"
  parse_expression = var.gitlab_deploy_request_fer_parse
  enabled          = true
}

resource "sumologic_field_extraction_rule" "gitlab_issue_fer" {
  count            = "${var.install_gitlab}" == "fer" || "${var.install_gitlab}" == "collection" || "${var.install_gitlab}" == "all" ? 1 : 0
  depends_on       = [sumologic_http_source.gitlab,restapi_object.gitlab_field]
  name             = "SDO - Gitlab Issue"
  scope            = "_sourceCategory=${var.gitlab_sc} ${var.gitlab_issue_request_fer_scope}"
  parse_expression = var.gitlab_issue_request_fer_parse
  enabled          = true
}


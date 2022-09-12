resource "aws_wafv2_web_acl" "waf_sql_inject" {
  name        = "webacl-waf_sql_inject"
  scope       = "CLOUDFRONT"

  default_action {
    block {}
  }

  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 0

    override_action {
      count {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "webacl-example"
    sampled_requests_enabled   = true
  }
}

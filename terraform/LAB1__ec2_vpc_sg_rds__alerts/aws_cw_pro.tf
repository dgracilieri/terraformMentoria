resource "aws_cloudwatch_dashboard" "EC2_Dashboard" {
  dashboard_name = "EC2-Dashboard"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "explorer",
            "width": 24,
            "height": 15,
            "x": 0,
            "y": 0,
            "properties": {
                "metrics": [
                    {
                        "metricName": "CPUUtilization",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Maximum"
                    }
                ],
                "aggregateBy": {
                    "key": "InstanceType",
                    "func": "MAX"
                },
                "labels": [
                    {
                        "key": "State",
                        "value": "running"
                    }
                ],
                "widgetOptions": {
                    "legend": {
                        "position": "bottom"
                    },
                    "view": "timeSeries",
                    "rowsPerPage": 8,
                    "widgetsPerRow": 2
                },
                "period": 60,
                "title": "Running EC2 Instances CPUUtilization"
            }
        }
    ]
}
EOF
}



resource "aws_cloudwatch_metric_alarm" "EC2_CPU_Usage_Alarm" {
  alarm_name                = "EC2_CPU_Usage_Alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "70"
  #alarm_actions             = "true"
  alarm_description         = "This metric monitors ec2 cpu utilization exceeding 70%"
}




/* module "metric_alarm" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 2.0"

  alarm_name          = "EC2_CPU_Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  threshold           = 70
  period              = 60
  unit                = "Count"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"
  statistic   = "Average"

  alarm_actions = ["arn:aws:sns:us-east-2:585584209241:cpu_utilization"]
} */
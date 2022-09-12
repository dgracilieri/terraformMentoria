# resource "aws_cloudwatch_dashboard" "EC2_Dashboard" {
#   dashboard_name = "EC2-Dashboard"

#   dashboard_body = <<EOF
# {
#     "widgets": [
#         {
#             "type": "explorer",
#             "width": 24,
#             "height": 15,
#             "x": 0,
#             "y": 0,
#             "properties": {
#                 "metrics": [
#                     {
#                         "metricName": "CPUUtilization",
#                         "resourceType": "AWS::EC2::Instance",
#                         "stat": "Maximum"
#                     }
#                 ],
#                 "aggregateBy": {
#                     "key": "InstanceType",
#                     "func": "MAX"
#                 },
#                 "labels": [
#                     {
#                         "key": "State",
#                         "value": "running"
#                     }
#                 ],
#                 "widgetOptions": {
#                     "legend": {
#                         "position": "bottom"
#                     },
#                     "view": "timeSeries",
#                     "rowsPerPage": 8,
#                     "widgetsPerRow": 2
#                 },
#                 "period": 60,
#                 "title": "Running EC2 Instances CPUUtilization"
#             }
#         }
#     ]
# }
# EOF
# }


# module "metric_alarm" {
#   source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
#   version = "~> 2.0"

#   alarm_name          = "EC2_CPU_Usage"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = 2
#   threshold           = 70
#   period              = 60
#   namespace   = "AWS/EC2"
#   metric_name = "CPUUtilization"
#   statistic   = "Average"
#   dimensions = {
#       AutoScalingGroupName = aws_autoscaling_group.asg_carancas.arn
#     }

#   alarm_actions = ["arn:aws:sns:us-east-1:756915900426:Default_CloudWatch_Alarms_Topic"]
# }


# resource "aws_autoscaling_policy" "sg" {
#   name                   = "asg_police"
#   scaling_adjustment     = 4
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
#   autoscaling_group_name = aws_autoscaling_group.asg_carancas.name
# }


# resource "aws_cloudwatch_metric_alarm" "sg" {
#   alarm_name          = "asg_metric"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "80"

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.asg_carancas.name
#   }

#   alarm_description = "This metric monitors ec2 cpu utilization"
#   alarm_actions     = [aws_autoscaling_policy.sg.arn]
# }


# resource "aws_cloudwatch_metric_alarm" "lb" {
#   alarm_name                = "lb_metric"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = "2"
#   threshold                 = "10"
#   alarm_description         = "Request error rate has exceeded 10%"
#   insufficient_data_actions = []

#   metric_query {
#     id          = "e1"
#     expression  = "m2/m1*100"
#     label       = "Error Rate"
#     return_data = "true"
#   }

#   metric_query {
#     id = "m1"

#     metric {
#       metric_name = "RequestCount"
#       namespace   = "AWS/ApplicationELB"
#       period      = "120"
#       stat        = "Sum"
#       unit        = "Count"

#       dimensions = {
#         LoadBalancer = "app/web"
#       }
#     }
#   }

#   metric_query {
#     id = "m2"

#     metric {
#       metric_name = "HTTPCode_ELB_5XX_Count"
#       namespace   = "AWS/ApplicationELB"
#       period      = "120"
#       stat        = "Sum"
#       unit        = "Count"

#       dimensions = {
#         TargetGroup  = aws_lb_target_group.tg-instances-carancas.arn_suffix
#         LoadBalancer = aws_lb.lb_carancas.arn_suffix
#       }
#     }
#   }
# }
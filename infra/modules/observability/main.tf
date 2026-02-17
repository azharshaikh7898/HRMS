resource "aws_cloudwatch_log_group" "app" {
  name              = "/hrms/${var.environment}/application"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = var.tags
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "${var.name_prefix}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "High CPU on EKS cluster"
  alarm_actions       = var.alarm_actions
  dimensions = {
    ClusterName = var.eks_cluster_name
  }
  tags = var.tags
}

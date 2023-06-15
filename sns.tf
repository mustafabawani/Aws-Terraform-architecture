resource "aws_sns_topic" "asg_events" {
  name = "asg-events"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.asg_events.arn
  protocol  = "email"
  endpoint  = "k191252@nu.edu.pk"
}

resource "aws_autoscaling_notification" "example" {
  group_names = [
    aws_autoscaling_group.Server_ASG.name,
  ]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
  topic_arn = aws_sns_topic.asg_events.arn
}

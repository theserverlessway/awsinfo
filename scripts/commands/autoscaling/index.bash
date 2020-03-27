awscli autoscaling describe-auto-scaling-groups --output table --query "AutoScalingGroups[$(auto_filter AutoScalingGroupName -- $@)].{
  \"1.Name\":AutoScalingGroupName,
  \"2.Min/Max Size\":join('/',[to_string(MinSize),to_string(MaxSize)]),
  \"3.Desired\":DesiredCapacity}"
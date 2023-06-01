AUTOSCALING_GROUPS=$(awscli autoscaling describe-auto-scaling-groups --output text --query "AutoScalingGroups[$(auto_filter_joined AutoScalingGroupName -- "$@")].[AutoScalingGroupName]")

select_one AutoScalingGroup "$AUTOSCALING_GROUPS"

awscli autoscaling describe-auto-scaling-groups --auto-scaling-group-names $SELECTED --output table --query "AutoScalingGroups[0]"
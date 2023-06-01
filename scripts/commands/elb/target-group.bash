split_args "$@"

source $CURRENT_COMMAND_DIR/loadbalancer_filter.sh
FILTER=$(create_filter $FIRST_RESOURCE)

LOAD_BALANCERS=$(awscli elbv2 describe-load-balancers --output text --query "LoadBalancers[$FILTER].[LoadBalancerArn]")
select_one LoadBalancer "$LOAD_BALANCERS"

TARGET_GROUP_FILTER=$(auto_filter_joined TargetGroupName 'to_string(Port)' Protocol -- $SECOND_RESOURCE)

TARGET_GROUPS=$(awscli elbv2 describe-target-groups --load-balancer-arn $SELECTED --output text --query "TargetGroups[$TARGET_GROUP_FILTER].[TargetGroupArn]")
select_one TargetGroup "$TARGET_GROUPS"

awscli elbv2 describe-target-groups --target-group-arns $SELECTED --output table \
  --query "TargetGroups[0]"

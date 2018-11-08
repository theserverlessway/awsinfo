split_args "$@"

FILTER=$(auto_filter LoadBalancerName VpcId Scheme "join('',AvailabilityZones[].ZoneName)" "join('',AvailabilityZones[].SubnetId)" "join('',SecurityGroups||[''])" -- $FIRST_RESOURCE)

LOAD_BALANCERS=$(awscli elbv2 describe-load-balancers --output text --query "LoadBalancers[$FILTER].[LoadBalancerArn]")
select_one LoadBalancer "$LOAD_BALANCERS"

TARGET_GROUP_FILTER=$(auto_filter TargetGroupName 'to_string(Port)' Protocol -- $SECOND_RESOURCE)

TARGET_GROUPS=$(awscli elbv2 describe-target-groups --load-balancer-arn $SELECTED --output text --query "TargetGroups[$TARGET_GROUP_FILTER].[TargetGroupArn]")
select_one TargetGroup "$TARGET_GROUPS"

awscli elbv2 describe-target-health --target-group-arn $SELECTED --output table \
  --query "TargetHealthDescriptions[].{ \
  \"1.Id\":Target.Id, \
  \"2.Port\":Target.Port, \
  \"3.AZ\":Target.AvailabilityZone, \
  \"4.HealthCheckPort\":HealthCheckPort, \
  \"5.State\":TargetHealth.State}"

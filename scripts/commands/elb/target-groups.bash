split_args "$@"

FILTER=$(auto_filter LoadBalancerName VpcId Scheme "join('',AvailabilityZones[].ZoneName)" "join('',AvailabilityZones[].SubnetId)" "join('',SecurityGroups||[''])" -- $FIRST_RESOURCE)

LOAD_BALANCERS=$(awscli elbv2 describe-load-balancers --output text --query "LoadBalancers[$FILTER].[LoadBalancerArn]")
select_one LoadBalancer "$LOAD_BALANCERS"

awscli elbv2 describe-target-groups --load-balancer-arn $SELECTED --output table \
  --query "TargetGroups[$(auto_filter TargetGroupName 'to_string(Port)' Protocol -- $SECOND_RESOURCE)].{ \
    \"1.Name\":TargetGroupName, \
    \"2.Protocol\":Protocol, \
    \"3.Port\":Port, \
    \"4.HealthCheckPath\":HealthCheckPath, \
    \"5.HealthCheckProtocol\":HealthCheckProtocol}"

split_args "$@"

FILTER=$(auto_filter LoadBalancerName VpcId Scheme "join('',AvailabilityZones[].ZoneName)" "join('',AvailabilityZones[].SubnetId)" "join('',SecurityGroups||[''])" -- $FIRST_RESOURCE)

LOAD_BALANCERS=$(awscli elbv2 describe-load-balancers --output text --query "LoadBalancers[$FILTER].[LoadBalancerArn]")
select_one LoadBalancer "$LOAD_BALANCERS"

awscli elbv2 describe-listeners --load-balancer-arn $SELECTED --output table \
  --query "Listeners[$(auto_filter 'to_string(Port)' Protocol -- $SECOND_RESOURCE)].{ \
    \"1.Port\":Port, \
    \"2.Protocol\":Protocol}"

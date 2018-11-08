split_args "$@"

FILTER=$(auto_filter LoadBalancerName VpcId Scheme "join('',AvailabilityZones[].ZoneName)" "join('',AvailabilityZones[].SubnetId)" "join('',SecurityGroups||[''])" -- $FIRST_RESOURCE)

LOAD_BALANCERS=$(awscli elbv2 describe-load-balancers --output text --query "LoadBalancers[$FILTER].[LoadBalancerArn]")
select_one LoadBalancer "$LOAD_BALANCERS"

LISTENER_FILTER=$(auto_filter "to_string(Port)" Protocol -- $SECOND_RESOURCE)

LISTENERS=$(awscli elbv2 describe-listeners --load-balancer-arn $SELECTED --output text --query "Listeners[$LISTENER_FILTER].[ListenerArn]")
select_one Listener "$LISTENERS"

awscli elbv2 describe-rules --listener-arn $SELECTED --output table

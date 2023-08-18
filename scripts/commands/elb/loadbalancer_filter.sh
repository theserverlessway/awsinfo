split_args "$@"

function create_filter() {
  auto_filter_joined LoadBalancerName VpcId Scheme LoadBalancerArn DNSName "join('',AvailabilityZones[].ZoneName)" "join('',AvailabilityZones[].SubnetId)" "join('',SecurityGroups||[''])" -- "$@"
}

LOADBALANCER_FILTER=$(create_filter $FIRST_RESOURCE)

LOAD_BALANCERS=$(awscli elbv2 describe-load-balancers --output text --query "LoadBalancers[$LOADBALANCER_FILTER].[LoadBalancerArn]")
select_one LoadBalancer "$LOAD_BALANCERS"

SELECTED_LOAD_BALANCER="$SELECTED"
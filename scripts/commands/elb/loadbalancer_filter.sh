function create_filter() {
  auto_filter_joined LoadBalancerName VpcId Scheme LoadBalancerArn DNSName "join('',AvailabilityZones[].ZoneName)" "join('',AvailabilityZones[].SubnetId)" "join('',SecurityGroups||[''])" -- "$@"
}
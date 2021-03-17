function create_filter() {
  auto_filter LoadBalancerName VpcId Scheme LoadBalancerArn DNSName "join('',AvailabilityZones[].ZoneName)" "join('',AvailabilityZones[].SubnetId)" "join('',SecurityGroups||[''])" -- $@
}
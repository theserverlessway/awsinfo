source $CURRENT_COMMAND_DIR/loadbalancer_filter.sh
FILTER=$(create_filter "$@")

awscli elbv2 describe-load-balancers --output table --query "LoadBalancers[$FILTER].{
  \"1.LoadBalancerName\":LoadBalancerName,
  \"2.Type\":Type,
  \"3.Scheme\":Scheme,
  \"4.VpcId\":VpcId,
  \"5.AZs\": AvailabilityZones||''|length(@),
  \"6.SGs\": SecurityGroups||''|length(@),
  \"7.IPType\":IpAddressType,
  \"8.DNSName\":DNSName
  }"
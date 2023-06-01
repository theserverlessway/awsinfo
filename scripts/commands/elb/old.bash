FILTER=$(auto_filter_joined LoadBalancerName VPCId "join('',AvailabilityZones)" "join('',Instances[].InstanceId)" -- $@)

awscli elb describe-load-balancers --query "LoadBalancerDescriptions[$FILTER]" --output table
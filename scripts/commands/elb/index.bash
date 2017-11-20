FILTER=$(auto_filter LoadBalancerName VPCId "join('',AvailabilityZones)" "join('',Instances[].InstanceId)" -- $@)

awscli elb describe-load-balancers --query "LoadBalancerDescriptions[$FILTER]" --output table
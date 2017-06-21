FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "LoadBalancerName" $@)
    FILTER_VPC+=$(filter_query "VPCId" $@)
    FILTER_SUBNET+=$(filter_query "Subnets[].[]" $@)
    FILTER_AZ+=$(filter_query "AvailabilityZones[]" $@)
    FILTER_INSTANCE+=$(filter_query "Instances[].InstanceId" $@)


    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_VPC $FILTER_SUBNET $FILTER_AZ $FILTER_INSTANCE)"
fi

awscli elb describe-load-balancers --query "LoadBalancerDescriptions[$FILTER_QUERY]" --output table
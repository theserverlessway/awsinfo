FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "$TAG_NAME" $@)
    FILTER_ID+=$(filter_query "SubnetId" $@)
    FILTER_VPC+=$(filter_query "VpcId" $@)
    FILTER_AZ+=$(filter_query "AvailabilityZone" $@)
    FILTER_CIDR+=$(filter_query "CidrBlock" $@)
    FILTER_STATE+=$(filter_query "State" $@)
    FILTER_MAPPUBLICIPONLAUNCH+=$(filter_query "to_string(MapPublicIpOnLaunch)" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID $FILTER_VPC $FILTER_AZ $FILTER_CIDR $FILTER_STATE $FILTER_MAPPUBLICIPONLAUNCH)"
fi

awscli ec2 describe-subnets --output table --query "Subnets[$FILTER_QUERY].{\"1.Name\":$TAG_NAME,\"2.Id\":SubnetId,\"3.VpcId\":VpcId,\"4.AZ\":AvailabilityZone,\"5.State\":State,\"6.CIDR\":CidrBlock,\"7.AvailableIp\":AvailableIpAddressCount,\"8.PublicIp\":to_string(MapPublicIpOnLaunch),\"9.DefaultForAz\":to_string(DefaultForAz),\"8.Ipv6\":to_string(AssignIpv6AddressOnCreation)}"

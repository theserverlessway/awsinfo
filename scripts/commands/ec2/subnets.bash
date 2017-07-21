FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_ID+=$(filter_query "SubnetId" $@)
    FILTER_VPC+=$(filter_query "VpcId" $@)
    FILTER_AZ+=$(filter_query "AvailabilityZone" $@)
    FILTER_CIDR+=$(filter_query "CidrBlock" $@)
    FILTER_STATE+=$(filter_query "State" $@)
    FILTER_MAPPUBLICIPONLAUNCH+=$(filter_query "to_string(MapPublicIpOnLaunch)" $@)

    FILTER_QUERY="?$(join "||" $FILTER_ID $FILTER_VPC $FILTER_AZ $FILTER_CIDR $FILTER_STATE $FILTER_MAPPUBLICIPONLAUNCH)"
fi

awscli ec2 describe-subnets --output table --query "Subnets[$FILTER_QUERY].{\"1.Id\":SubnetId,\"2.VpcId\":VpcId,\"3.AZ\":AvailabilityZone,\"4.State\":State,\"5.CIDR\":CidrBlock,\"6.AvailableIp\":AvailableIpAddressCount,\"6.PublicIp\":to_string(MapPublicIpOnLaunch),\"7.DefaultForAz\":to_string(DefaultForAz),\"8.Ipv6\":to_string(AssignIpv6AddressOnCreation)}"

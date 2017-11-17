FILTER=$(auto_filter "$TAG_NAME" SubnetId VpcId AvailabilityZone CidrBlock State "to_string(MapPublicIpOnLaunch)" -- $@)

awscli ec2 describe-subnets --output table --query "Subnets[$FILTER].{\"1.Name\":$TAG_NAME,\"2.Id\":SubnetId,\"3.VpcId\":VpcId,\"4.AZ\":AvailabilityZone,\"5.State\":State,\"6.CIDR\":CidrBlock,\"7.AvailableIp\":AvailableIpAddressCount,\"8.PublicIp\":to_string(MapPublicIpOnLaunch),\"9.DefaultForAz\":to_string(DefaultForAz),\"8.Ipv6\":to_string(AssignIpv6AddressOnCreation)}"

FILTER=$(auto_filter AvailabilityZone Description NetworkInterfaceId RequesterId SubnetId VpcId PrivateIpAddress PrivateDnsName RequesterId "join('',Groups[].GroupId)" "$TAG_NAME" -- $@)

awscli ec2 describe-network-interfaces --output table \
  --query "NetworkInterfaces[$FILTER].{ \
    \"1.Name\":$TAG_NAME,\
    \"2.Id\":NetworkInterfaceId,\
    \"3.IP\":PrivateIpAddress,\
    \"4.Requester\":RequesterId,\
    \"5.Subnet\":SubnetId,\
    \"6.VPC\":VpcId,\
    \"7.AZ\":AvailabilityZone,\
    \"8.SecurityGroups\":join(', ',Groups[].GroupId)}"

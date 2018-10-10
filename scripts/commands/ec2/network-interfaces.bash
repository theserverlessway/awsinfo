FILTER=$(auto_filter AvailabilityZone Description NetworkInterfaceId RequesterId SubnetId VpcId PrivateIpAddress PrivateDnsName "join('', Groups[].GroupId)" "$TAG_NAME" -- $@)

awscli ec2 describe-network-interfaces --output table \
  --query "NetworkInterfaces[$FILTER].{ \
    \"1.Name\":$TAG_NAME, \
    \"2.Id\":NetworkInterfaceId, \
    \"3.Subnet\":SubnetId, \
    \"4.VPC\":VpcId, \
    \"4.AZ\":AvailabilityZone, \
    \"5.SecurityGroups\":join(', ', Groups[].GroupId)}"

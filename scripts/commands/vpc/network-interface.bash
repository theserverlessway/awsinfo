FILTER=$(auto_filter_joined AvailabilityZone Description NetworkInterfaceId RequesterId SubnetId VpcId PrivateIpAddress PrivateDnsName "join('',Groups[].GroupId)" "$TAG_NAME" -- "$@")

NETWORK_INTERFACES=$(awscli ec2 describe-network-interfaces --output text --query "NetworkInterfaces[$FILTER].[NetworkInterfaceId]")
select_one NetworkInterface "$NETWORK_INTERFACES"

awscli ec2 describe-network-interfaces --network-interface-ids $SELECTED --output table --query "NetworkInterfaces[0]"

awscli ec2 describe-nat-gateways --output table \
  --query "NatGateways[$(auto_filter_joined NatGatewayId State SubnetId VpcId -- "$@")].{ \
    \"1.Id\":NatGatewayId, \
    \"2.State\":State, \
    \"3.Vpc\":VpcId, \
    \"4.Subnet\":SubnetId, \
    \"5.NetworkInterface\":NatGatewayAddresses[0].NetworkInterfaceId, \
    \"6.PrivateIp\":NatGatewayAddresses[0].PrivateIp, \
    \"7.PublicIp\":NatGatewayAddresses[0].PublicIp}"

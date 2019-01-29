FILTER=$(auto_filter "join('',ServiceType[].ServiceType||[''])" ServiceName Owner "join('',AvailabilityZones||[])" -- $@)

awscli ec2 describe-vpc-endpoint-services --output table \
  --query "ServiceDetails[$FILTER].{ \
    \"1.ServiceName\":ServiceName, \
    \"2.ServiceType\":join(', ', ServiceType[].ServiceType), \
    \"3.Owner\":Owner, \
    \"4.BaseEndpointDnsNames\":join(',', BaseEndpointDnsNames), \
    \"5.PrivateDnsName\":PrivateDnsName, \
    \"6.AvailabilityZones\":join(', ', AvailabilityZones)
    \"7.VpcEndpointPolicy\":VpcEndpointPolicySupported, \
    \"8.AcceptanceRequired\":AcceptanceRequired }"

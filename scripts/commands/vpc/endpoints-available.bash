FILTER=$(auto_filter "join('',ServiceType[].ServiceType||[''])" ServiceName Owner "join('',AvailabilityZones||[])" -- $@)

awscli ec2 describe-vpc-endpoint-services --output table \
  --query "ServiceDetails[$FILTER].{ \
    \"1.ServiceName\":ServiceName, \
    \"2.ServiceType\":join(', ', ServiceType[].ServiceType), \
    \"3.Owner\":Owner}"

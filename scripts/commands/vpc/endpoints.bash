FILTER=$(auto_filter VpcEndpointId VpcEndpointType VpcId ServiceName -- $@)

awscli ec2 describe-vpc-endpoints --output table \
  --query "VpcEndpoints[$FILTER].{
    \"1.Id\":VpcEndpointId,
    \"2.Type\":VpcEndpointType,
    \"3.VpcId\":VpcId,
    \"4.ServiceName\":ServiceName,
    \"4.State\":State}"

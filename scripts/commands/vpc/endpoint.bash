FILTER=$(auto_filter VpcEndpointId VpcEndpointType VpcId ServiceName "join('',SubnetIds)" -- $@)

ENDPOINTS=$(awscli ec2 describe-vpc-endpoints --output text --query "VpcEndpoints[$FILTER].[VpcEndpointId]")

select_one Endpoint "$ENDPOINTS"

awscli ec2 describe-vpc-endpoints --vpc-endpoint-ids $SELECTED --output table

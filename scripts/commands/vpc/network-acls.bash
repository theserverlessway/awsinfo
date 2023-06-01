SUBNETS="join(',',Associations[].SubnetId)"

FILTER=$(auto_filter_joined VpcId NetworkAclId $SUBNETS $TAG_NAME -- $@)

awscli ec2 describe-network-acls --output table --query "NetworkAcls[$FILTER].{
    \"1.Name\":$TAG_NAME,
    \"2.VpcId\":VpcId,
    \"3.NetworkAclId\":NetworkAclId,
    \"4.Default\":IsDefault,
    \"5.Subnets\":$SUBNETS}"

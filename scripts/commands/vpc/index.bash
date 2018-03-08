FILTER=$(auto_filter VpcId "$TAG_NAME" IsDefault -- $@)
awscli ec2 describe-vpcs --output table --query "Vpcs[$FILTER].{ \
  \"1.Name\":$TAG_NAME, \
  \"2.Id\": VpcId, \
  \"3.CidrBlock\": CidrBlock, \
  \"4.State\": State, \
  \"5.InstanceTenancy\":InstanceTenancy, \
  \"6.IsDefault\": IsDefault}"
source $CURRENT_COMMAND_DIR/terminated-instances.sh

SECURITY_GROUPS="NetworkInterfaces|length(@)"
FILTER=$(auto_filter "$TAG_NAME" InstanceId InstanceType State.Name Placement.AvailabilityZone "$SECURITY_GROUPS" PublicIpAddress PrivateIpAddress -- $@)

awscli ec2 describe-instances --output table $EC2_FILTER --query "sort_by($SORT_BY)[].Instances[$FILTER][].{
  \"1.Name\":$TAG_NAME,
  \"2.InstanceId\":InstanceId,
  \"3.Type\":InstanceType,
  \"4.State\":State.Name,
  \"5.NetIf\":$SECURITY_GROUPS,
  \"6.LaunchTime\":LaunchTime,
  \"7.AZ\":Placement.AvailabilityZone,
  \"8.PublicIP\":PublicIpAddress,
  \"9.PrivateIP\":PrivateIpAddress}"
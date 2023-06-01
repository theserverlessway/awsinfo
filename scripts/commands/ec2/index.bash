source $CURRENT_COMMAND_DIR/terminated-instances.sh

FILTER=$(auto_filter_joined "$TAG_NAME" InstanceId InstanceType State.Name Placement.AvailabilityZone PublicIpAddress PrivateIpAddress InstanceLifecycle -- "$@")

awscli ec2 describe-instances --output table $EC2_FILTER --query "sort_by($SORT_BY)[].Instances[$FILTER][].{
  \"1.Name\":$TAG_NAME,
  \"2.InstanceId\":InstanceId,
  \"3.Type\":InstanceType,
  \"4.State\":State.Name,
  \"5.InstanceLifecycle\":InstanceLifecycle||'on-demand',
  \"6.LaunchTime\":LaunchTime,
  \"7.AZ\":Placement.AvailabilityZone,
  \"8.PublicIP\":PublicIpAddress,
  \"9.PrivateIP\":PrivateIpAddress}"
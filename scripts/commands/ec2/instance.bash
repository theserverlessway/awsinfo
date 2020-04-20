source $CURRENT_COMMAND_DIR/terminated-instances.sh

SECURITY_GROUPS="NetworkInterfaces|length(@)"
FILTER=$(auto_filter "$TAG_NAME" InstanceId InstanceType State.Name Placement.AvailabilityZone "$SECURITY_GROUPS" PublicIpAddress PrivateIpAddress -- $@)

INSTANCE_LIST=$(awscli ec2 describe-instances --output text $EC2_FILTER --query "sort_by(Reservations,&Instances[0].LaunchTime)[].Instances[$FILTER].InstanceId")

select_one Instance "$INSTANCE_LIST"

awscli ec2 describe-instances --instance-ids $SELECTED --output table $EC2_FILTER --query "sort_by(Reservations,&Instances[0].LaunchTime)[].Instances[0][]"

EC2_FILTER="--filter Name=instance-state-name,Values=pending,running"

SECURITY_GROUPS="NetworkInterfaces|length(@)"
FILTER=$(auto_filter_joined "$TAG_NAME" InstanceId InstanceType State.Name Placement.AvailabilityZone "$SECURITY_GROUPS" -- $@)

INSTANCE_LISTING=$(awscli ec2 describe-instances --output text $EC2_FILTER --query "sort_by(Reservations,&Instances[0].InstanceId)[].Instances[$FILTER][].[InstanceId]")

select_one Instance "$INSTANCE_LISTING"

awscli ssm start-session --target $SELECTED
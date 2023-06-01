FILTER=$(auto_filter_joined "$TAG_NAME" SubnetId VpcId AvailabilityZone CidrBlock State "to_string(MapPublicIpOnLaunch)" -- $@)

SUBNET_LISTING=$(awscli ec2 describe-subnets --output text --query "sort_by(Subnets,&SubnetId)[$FILTER].[SubnetId]")
select_one Subnet "$SUBNET_LISTING"

awscli ec2 describe-subnets --subnet-ids $SELECTED --output table

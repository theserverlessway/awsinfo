FILTER=$(auto_filter_joined "$TAG_NAME" GroupId GroupName VpcId Description -- $@)

awscli ec2 describe-security-groups --output table --query "SecurityGroups[$FILTER].{\"1.Name\":$TAG_NAME,\"2.GroupId\":GroupId,\"3.GroupName\":GroupName,\"4.VpcId\":VpcId,\"5.Description\":Description}"

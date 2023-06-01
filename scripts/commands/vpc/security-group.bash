PERMISSIONS_QUERY=""

PERMISSION="{\"1.FromPort\":FromPort||'',\"2.ToPort\":ToPort||'',\"3.IpProtocol\":IpProtocol||'',\"4.Ipv4Ranges\":IpRanges[].CidrIp, \"5.Ipv6Ranges\":Ipv6Ranges[].CidrIp,\"6.UserIdGroupPairs\":UserIdGroupPairs}"
PERMISSIONS_QUERY="\"6.Permissions\":{In:IpPermissions[].$PERMISSION,Out:IpPermissionsEgress[].$PERMISSION}"

FILTER=$(auto_filter_joined "$TAG_NAME" GroupId GroupName VpcId -- "$@")

SECURITY_GROUPS=$(awscli ec2 describe-security-groups --output text --query "SecurityGroups[$FILTER].[GroupId]")
select_one SecurityGroup "$SECURITY_GROUPS"

awscli ec2 describe-security-groups --group-id $SELECTED --output table --query "SecurityGroups[0]"

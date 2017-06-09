FILTER_QUERY=""
PERMISSIONS_QUERY=""

PERMISSION="{\"P1.FromPort\":FromPort||'',\"P2.ToPort\":ToPort||'',\"P3.IpProtocol\":IpProtocol||'',\"P4.Ipv4Ranges\":IpRanges[].CidrIp, \"P5.Ipv6Ranges\":Ipv6Ranges[].CidrIp,\"P6.UserIdGroupPairs\":UserIdGroupPairs}"

while getopts "p" opt;
do
   case "$opt" in
       p) PERMISSIONS_QUERY="\"6.Permissions\":{In:IpPermissions[].$PERMISSION,Out:IpPermissionsEgress[].$PERMISSION}" ;;
   esac
done
shift $(($OPTIND-1))


if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "$TAG_NAME" $@)
    FILTER_ID+=$(filter_query "GroupId" $@)
    FILTER_GROUP_NAME+=$(filter_query "GroupName" $@)
    FILTER_VPC_ID+=$(filter_query "VpcId" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID $FILTER_GROUP_NAME $FILTER_VPC_ID)"
fi

aws ec2 describe-security-groups --output table --query "SecurityGroups[$FILTER_QUERY].{\"1.Name\":$TAG_NAME,\"2.GroupId\":GroupId,\"3.GroupName\":GroupName,\"4.VpcId\":VpcId,\"5.Description\":Description$PERMISSIONS_QUERY}"
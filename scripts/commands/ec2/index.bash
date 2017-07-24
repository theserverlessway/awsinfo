FILTER_QUERY=""

SECURITY_GROUPS="join(', ',NetworkInterfaces[].Groups[].GroupId)"

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "$TAG_NAME" $@)
    FILTER_ID+=$(filter_query "InstanceId" $@)
    FILTER_TYPE+=$(filter_query "InstanceType" $@)
    FILTER_STATE+=$(filter_query "State.Name" $@)
    FILTER_AZ+=$(filter_query "Placement.AvailabilityZone" $@)
    FILTER_SG+=$(filter_query "$SECURITY_GROUPS" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID $FILTER_TYPE $FILTER_STATE $FILTER_AZ $FILTER_SG)"
fi

awscli ec2 describe-instances --output table --query "Reservations[].Instances[$FILTER_QUERY][].{\"1.Name\":$TAG_NAME,\"2.InstanceId\":InstanceId,\"3.Type\":InstanceType,\"4.State\":State.Name,\"5.SecurityGroups\":$SECURITY_GROUPS,\"6.LaunchTime\":LaunchTime,\"7.AZ\":Placement.AvailabilityZone,\"8.PublicDNS\":PublicDnsName}"
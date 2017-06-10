FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "InstanceProfileName" $@)
    FILTER_ID+=$(filter_query "InstanceProfileId" $@)
    FILTER_ROLE_NAME+=$(filter_query "Roles[0].RoleName" $@)
    FILTER_ROLE_ID+=$(filter_query "Roles[0].RoleId" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID $FILTER_ROLE_NAME $FILTER_ROLE_ID)"
fi

awscli iam list-instance-profiles --output table --query "InstanceProfiles[$FILTER_QUERY].{\"1.Name\":InstanceProfileName,\"2.Id\":InstanceProfileId,\"3.RoleName\":Roles[0].RoleName,\"4.RoleId\":Roles[0].RoleId}"
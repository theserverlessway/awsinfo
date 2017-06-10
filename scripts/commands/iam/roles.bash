FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "RoleName" $@)
    FILTER_ID+=$(filter_query "RoleId" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID)"
fi

awscli iam list-roles --output table --query "Roles[$FILTER_QUERY].{\"1.Name\":RoleName,\"2.Id\":RoleId,\"3.Arn\":Arn}"
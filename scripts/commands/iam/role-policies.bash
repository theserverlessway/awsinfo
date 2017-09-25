FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "RoleName" $@)
    FILTER_ID+=$(filter_query "RoleId" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID)"
fi

ROLES=$(awscli iam list-roles --output text --query "Roles[$FILTER_QUERY].[RoleName]")
select_one Role "$ROLES"

awscli iam list-role-policies --role-name $SELECTED --output table --query "PolicyNames[].{\"1.PolicyName\":@}"
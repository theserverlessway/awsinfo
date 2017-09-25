FILTER_QUERY=""

split_args "$@"

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "RoleName" $FIRST_RESOURCE)
    FILTER_ID+=$(filter_query "RoleId" $FIRST_RESOURCE)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID)"
fi

ROLES=$(awscli iam list-roles --output text --query "Roles[$FILTER_QUERY].[RoleName]")
select_one Role "$ROLES"

ROLE=$SELECTED

ROLES=$(awscli iam list-role-policies --role-name $ROLE --output text --query "PolicyNames[$(filter @ $SECOND_RESOURCE)].[@]")
select_one Policy "$ROLES"

awscli iam get-role-policy --role-name $ROLE --policy-name $SELECTED --output table --query "@.{\"1.Statements\":PolicyDocument.Statement}"
FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "GroupName" $@)
    FILTER_ID+=$(filter_query "GroupId" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID)"
fi

awscli iam list-groups --output table --query "Groups[$FILTER_QUERY].{\"1.Name\":GroupName,\"2.Id\":GroupId,\"3.Arn\":Arn}"
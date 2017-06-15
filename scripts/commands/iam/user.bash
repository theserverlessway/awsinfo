FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "UserName" $@)
    FILTER_ID+=$(filter_query "UserId" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID)"
fi

LOG_GROUP=$(select_one LogGroup logs describe-log-groups --query "logGroups[$(filter "logGroupName" $@)].[logGroupName]")

awscli iam list-users --output table --query "Users[$FILTER_QUERY].{\"1.Name\":UserName,\"2.Id\":UserId,\"3.Arn\":Arn}"
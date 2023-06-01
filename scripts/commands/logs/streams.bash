split_args "$@"

LOG_GROUPS=$(awscli logs describe-log-groups --query "logGroups[$(auto_filter_joined logGroupName -- "$FIRST_RESOURCE")].[logGroupName]" --output text)
select_one GROUP "$LOG_GROUPS"

awscli logs describe-log-streams --log-group-name "$SELECTED" --query "logStreams[$(auto_filter_joined logStreamName -- "$SECOND_RESOURCE")].[logStreamName]" --output table

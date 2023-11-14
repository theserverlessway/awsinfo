split_args "$@"

REPORT_GROUPS=$(awscli codebuild list-report-groups --output text --query "reportGroups[$(auto_filter_joined @ -- "$FIRST_RESOURCE")].[@]")
select_one ReportGroup "$REPORT_GROUPS"

awscli codebuild list-reports-for-report-group --report-group-arn "$SELECTED" --output table --query "reverse(reports)[$(auto_filter_joined @ -- "$SECOND_RESOURCE")]"
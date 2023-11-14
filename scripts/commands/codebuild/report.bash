split_args "$@"

REPORT_GROUPS=$(awscli codebuild list-report-groups --output text --query "reportGroups[$(auto_filter_joined @ -- "$FIRST_RESOURCE")].[@]")
select_one ReportGroup "$REPORT_GROUPS"

REPORT_ARNS=$(awscli codebuild list-reports-for-report-group --report-group-arn "$SELECTED" --query "reports[$(auto_filter_joined @ -- "$SECOND_RESOURCE")].[@]" --output text)

select_one_unsorted Reports "$REPORT_ARNS"

awscli codebuild batch-get-reports --report-arns "$SELECTED" --query reports --output table
split_args "$@"

STACKSET_LISTING=$(awscli cloudformation list-stack-sets --status ACTIVE --output text --query "sort_by(Summaries,&StackSetName)[$(auto_filter_joined StackSetName -- "$FIRST_RESOURCE")].[StackSetName]")
select_one StackSet "$STACKSET_LISTING"

awscli cloudformation list-stack-set-operations --stack-set-name $SELECTED --output table --max-results 20 --query "sort_by(Summaries,&CreationTimestamp)[$(auto_filter_joined OperationId Action Status -- "$SECOND_RESOURCE")].{
  \"1.Id\":OperationId,
  \"2.Action\":Action,
  \"3.Status\":Status,
  \"4.CreationTimestamp\":CreationTimestamp,
  \"5.EndTimestamp\":EndTimestamp}"

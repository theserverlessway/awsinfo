split_args "$@"

STACKSET_LISTING=$(awscli cloudformation list-stack-sets --status ACTIVE --output text --query "sort_by(Summaries,&StackSetName)[$(auto_filter StackSetName -- $FIRST_RESOURCE)].[StackSetName]")
select_one StackSet "$STACKSET_LISTING"

awscli cloudformation list-stack-instances --stack-set-name $SELECTED --output table --query "sort_by(Summaries,&join('',[@.Account,@.Region]))[$(auto_filter Account Region -- $SECOND_RESOURCE)].{
  \"1.Account\":Account,
  \"2.Region\":Region,
  \"3.Status\":Status}"

split_args "$@"

STACKSET_LISTING=$(awscli cloudformation list-stack-sets --status ACTIVE --output text --query "sort_by(Summaries,&StackSetName)[$(auto_filter StackSetName -- $FIRST_RESOURCE)].[StackSetName]")
select_one StackSet "$STACKSET_LISTING"

OUTPUT=$(awscli cloudformation list-stack-instances --stack-set-name $SELECTED --output json --query "sort_by(Summaries,&join('',[@.Account,@.Region]))[$(auto_filter Account Region StackId Status -- $SECOND_RESOURCE)].{
  \"1.Account\":Account,
  \"2.Region\":Region,
  \"3.StackName\":StackId,
  \"4.Status\":Status,
  \"4.StatusReason\":StatusReason}" |   sed "s/arn.*stack\/\(.*\)\/.*\"/\1\"/g")

echo -e $OUTPUT | python $DIR/combine_calls.py ListStackInstances

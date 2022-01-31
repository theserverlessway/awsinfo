split_args "$@"

STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(auto_filter StackName -- $FIRST_RESOURCE)].[StackName]")
select_one Stack "$STACK_LISTING"

awscli cloudformation list-stack-resources --stack-name $SELECTED --output table \
  --query "StackResourceSummaries[$(auto_filter LogicalResourceId PhysicalResourceId ResourceType -- $SECOND_RESOURCE)].{ \
    \"1.LogicalId\":LogicalResourceId, \
    \"2.PhysicalId\":PhysicalResourceId, \
    \"3.Type\":ResourceType, \
    \"4.Status\":ResourceStatus, \
    \"5.LastUpdated\":LastUpdatedTimestamp}"

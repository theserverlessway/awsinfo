STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(auto_filter_joined StackName -- "$@")].[StackName]")
select_one Stack "$STACK_LISTING"

echo "Most recent events are on the bottom"

awscli cloudformation describe-stack-events --stack-name $SELECTED --query "StackEvents[0:50]|reverse(@)[].{\"1.Timestamp\":Timestamp,\"2.Status\":ResourceStatus,\"3.LogicalId\":LogicalResourceId,\"4.ResourceType\": ResourceType,\"5.Log\":ResourceStatusReason||''}" --output table
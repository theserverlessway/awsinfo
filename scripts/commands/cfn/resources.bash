STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(filter StackName $@)].[StackName]")
select_one Stack "$STACK_LISTING"

awscli cloudformation list-stack-resources --stack-name $SELECTED --output table --query "StackResourceSummaries[].{\"1.LogicalId\":LogicalResourceId,\"2.PhysicalId\":PhysicalResourceId,\"3.Type\":ResourceType\"4.Status\":ResourceStatus,\"5.LastUpdated\":LastUpdatedTimestamp}"
STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(filter StackName $@)].[StackName]")
select_one Stack "$STACK_LISTING"

awscli cloudformation list-change-sets --stack-name $SELECTED --output table --query "Summaries[].{\"1.Stack\":StackName,\"2.ChangeSetName\":ChangeSetName,\"3.Status\":Status,\"4.Executable\":ExecutionStatus,\"5.CreatedAt\":CreationTime}"

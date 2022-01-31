split_args "$@"

STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(auto_filter StackName -- $FIRST_RESOURCE)].[StackName]")
select_one Stack "$STACK_LISTING"

awscli cloudformation describe-stacks --stack-name $SELECTED --output table --query "Stacks[].Outputs[$(auto_filter OutputKey -- $SECOND_RESOURCE)].{\"1.Key\":OutputKey,\"2.Value\":OutputValue}"
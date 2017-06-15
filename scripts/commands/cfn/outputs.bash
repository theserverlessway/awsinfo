STACK_LISTING=$(aws cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(filter StackName $@)].[StackName]")
select_one Stack "$STACK_LISTING"

awscli cloudformation describe-stacks --stack-name $SELECTED --output table --query "Stacks[].Outputs[].{\"1.Key\":OutputKey,\"2.Value\":OutputValue}"
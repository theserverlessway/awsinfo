STACK_LISTING=$(aws cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(filter StackName $@)].[StackName]")
select_one Stack "$STACK_LISTING"

awscli cloudformation get-stack-policy --stack-name $SELECTED --query "StackPolicyBody" --output text | jq .
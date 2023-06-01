STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(auto_filter_joined StackName -- $@)].[StackName]")
select_one Stack "$STACK_LISTING"

awscli cloudformation get-template --stack-name $SELECTED
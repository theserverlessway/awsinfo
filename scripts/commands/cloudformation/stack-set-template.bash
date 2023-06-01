STACKSET_LISTING=$(awscli cloudformation list-stack-sets --status ACTIVE --output text --query "sort_by(Summaries,&StackSetName)[$(auto_filter_joined StackSetName -- "$@")].[StackSetName]")
select_one StackSet "$STACKSET_LISTING"

awscli cloudformation describe-stack-set --stack-set-name "$SELECTED" --output text --query StackSet.TemplateBody

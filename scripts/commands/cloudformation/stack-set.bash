STACKSET_LISTING=$(awscli cloudformation list-stack-sets --status ACTIVE --output text --query "sort_by(Summaries,&StackSetName)[$(auto_filter_joined StackSetName -- "$@")].[StackSetName]")
select_one StackSet "$STACKSET_LISTING"

awscli cloudformation describe-stack-set --stack-set-name "$SELECTED" --output table --query "StackSet.{
  \"1.Name\":StackSetName,
  \"2.AdministrationRoleARN\":AdministrationRoleARN,
  \"3.ExecutionRoleName\":ExecutionRoleName,
  \"4.Parameters\":Parameters||[[]],
  \"5.Capabilities\":Capabilities||[[]],
  \"6.Tags\":Tags||[[]]}"

split_args "$@"

STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(auto_filter StackName -- $FIRST_RESOURCE)].[StackName]")

select_one Stack "$STACK_LISTING"

STACK=$SELECTED

CHANGE_SETS=$(awscli cloudformation list-change-sets --stack-name $SELECTED --query "Summaries[$(auto_filter ChangeSetName -- $SECOND_RESOURCE)].[ChangeSetName]" --output text)
select_one CHANGE-SET "$CHANGE_SETS"

awscli cloudformation describe-change-set --stack-name $STACK --change-set-name "$SELECTED" --output table --query "{
  \"1.Stack\":StackName,
  \"2.ChangeSetName\":ChangeSetName,
  \"3.Status\":Status,
  \"4.Executable\":ExecutionStatus,
  \"5.CreatedAt\":CreationTime,
  \"6.Parameters\":sort_by(Parameters||[{ParameterKey: '', ParameterValue:''}], &ParameterKey),
  \"7.Changes\":sort_by(Changes||[], &ResourceChange.LogicalResourceId)[].
  {\"1.Action\":ResourceChange.Action,
  \"2.LogicalId\":ResourceChange.LogicalResourceId,
  \"3.Type\":ResourceChange.ResourceType,
  \"4.Replacement\":ResourceChange.Replacement,
  \"5.Scopes\":join(', ', ResourceChange.Scope),
  \"6.StaticChanges\": join(', ', sort(ResourceChange.Details[?Evaluation=='Static'].Target.Name)),
  \"7.DynamicChanges\":join(', ', sort(ResourceChange.Details[?Evaluation=='Dynamic'].Target.Name))}}"
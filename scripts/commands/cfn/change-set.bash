split_args "$@"

STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(filter StackName $FIRST_RESOURCE)].[StackName]")

select_one Stack "$STACK_LISTING"

STACK=$SELECTED

CHANGE_SETS=$(awscli cloudformation list-change-sets --stack-name $SELECTED --query "Summaries[$(filter ChangeSetName $SECOND_RESOURCE)].[ChangeSetName]" --output text)
select_one CHANGE-SET "$CHANGE_SETS"

awscli cloudformation describe-change-set --stack-name $STACK --change-set-name "$SELECTED" --output table --query "{\"1.Stack\":StackName,\"2.ChangeSetName\":ChangeSetName,\"3.Status\":Status,\"4.Executable\":ExecutionStatus,\"5.CreatedAt\":CreationTime,\"6.Changes\":Changes[].{\"1.Action\":ResourceChange.Action,\"2.LogicalId\":ResourceChange.LogicalResourceId,\"3.Type\":ResourceChange.ResourceType,\"4.Replacement\":ResourceChange.Replacement,\"5.DirectChange\": join(', ', ResourceChange.Details[?Evaluation=='Static'].Target.Name),\"6.DependentChange\":join(', ', ResourceChange.Details[?Evaluation=='Dynamic'].Target.Name)}}"
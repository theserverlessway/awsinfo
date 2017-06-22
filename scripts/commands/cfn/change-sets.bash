STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(filter StackName $@)].[StackName]")
select_one Stack "$STACK_LISTING"

CHANGE_SETS=$(awscli cloudformation list-change-sets --stack-name $SELECTED --query "Summaries[].[ChangeSetId]" --output text | sort)

if [[ ! -z "$CHANGE_SETS" ]]
then
    for change_set in "$CHANGE_SETS"
    do
       awscli cloudformation describe-change-set --change-set-name "$change_set" --output table --query "\"{\"1.Stack\":StackName,\"2.ChangeSetName\":ChangeSetName,\"3.Status\":Status,\"4.Executable\":ExecutionStatus,\"5.CreatedAt\":CreationTime,\"6.Changes\":Changes[].{\"1.Action\":ResourceChange.Action,\"2.LogicalId\":ResourceChange.LogicalResourceId,\"3.Type\":ResourceChange.ResourceType,\"4.Replacement\":ResourceChange.Replacement,\"5.DirectChange\": join(', ', ResourceChange.Details[?Evaluation=='Static'].Target.Name),\"6.DependentChange\":join(', ', ResourceChange.Details[?Evaluation=='Dynamic'].Target.Name)}}\""
    done
else
    echo "No ChangeSets found for Stack $SELECTED"
fi
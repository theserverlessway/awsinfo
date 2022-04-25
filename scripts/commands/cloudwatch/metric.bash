# Example of Two Step Filtering
# Here we want to get all details for a specific ChangeSet.


# At first we're splitting the incoming arguments to provide two separate filters, e.g. `awsinfo cfn change-set xyz -- abc`.

split_args "$@"

# Then we're listing all available Stacks and filter them based on their StackName and
# $FIRST_RESOURCE (which is the filter values before --).

STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(auto_filter StackName -- $FIRST_RESOURCE)].[StackName]")

# Once we've listed all the Stacks we need to select one to use. In case there is only one in our list of filtered
# Stacks it will simply select that one. In case there are multiple it will print all and select the first.
select_one Stack "$STACK_LISTING"

# By Default the select_one function sets the SELECTED variable, but because we're selecting a second time below we
# have to store the value in a separate variable.
STACK=$SELECTED

# Here we're listing all ChangeSets and filter them on ChangeSetName and with the second Filter Resource.
CHANGE_SETS=$(awscli cloudformation list-change-sets --stack-name $SELECTED --query "Summaries[$(auto_filter ChangeSetName -- $SECOND_RESOURCE)].[ChangeSetName]" --output text)

# And again Select a ChangeSet as before and set the SELECTED variable to that Change Set
select_one CHANGE-SET "$CHANGE_SETS"

# Now we can call the `describe-change-set` command with the Stack and ChangeSet we selected above.
# The output is set to table and we're using the Query option to select the values we want to have.
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
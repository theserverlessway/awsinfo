split_args "$@"

PIPELINES=$(awscli codepipeline list-pipelines --output text --query "pipelines[$(auto_filter_joined name version -- $FIRST_RESOURCE)].[name]")
select_one Pipeline "$PIPELINES"

FILTER=$(auto_filter_joined "join('',actionStates[].actionName||[''])" -- $SECOND_RESOURCE)

awscli codepipeline list-action-executions --pipeline-name $SELECTED --output table --max-items 100 --query "actionExecutionDetails[$(auto_filter_joined pipelineExecutionId stageName actionName status -- $SECOND_RESOURCE)].{
  \"1.ExecutionId\":pipelineExecutionId,
  \"2.Stage\":stageName,
  \"3.Action\":actionName,
  \"4.Status\":status,
  \"5.StartTime\":startTime}"
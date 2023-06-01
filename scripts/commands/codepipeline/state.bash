PIPELINES=$(awscli codepipeline list-pipelines --output text --query "pipelines[$(auto_filter_joined name version -- "$@")].[name]")

select_one Pipeline "$PIPELINES"

awscli codepipeline get-pipeline-state --name "$SELECTED" --output table --query "stageStates[].{\"1.StageName\": stageName, \"2.LatestExecution\":latestExecution.pipelineExecutionId, \"3.Actions\": actionStates[].{
  \"1.ActionName\": actionName,
  \"2.ActionStatus\": latestExecution.status,
  \"3.Revision\": currentRevision.revisionId || ''}}"
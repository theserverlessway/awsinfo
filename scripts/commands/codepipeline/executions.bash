split_args "$@"

PIPELINES=$(awscli codepipeline list-pipelines --output text --query "pipelines[$(auto_filter name version -- $FIRST_RESOURCE)].[name]")
select_one Pipeline "$PIPELINES"

FILTER=$(auto_filter pipelineExecutionId status "join('',sourceRevisions[].revisionId||[''])" -- $SECOND_RESOURCE)

awscli codepipeline list-pipeline-executions --pipeline-name "$SELECTED" --output table --query "pipelineExecutionSummaries[$FILTER].{
  \"1.ExecutionId\":pipelineExecutionId,
  \"2.RevisionId\":join(', ',sourceRevisions[].revisionId||['']),
  \"3.Status\":status,
  \"4.StartTime\":startTime}"
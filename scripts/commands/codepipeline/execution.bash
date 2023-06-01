split_args "$@"

PIPELINES=$(awscli codepipeline list-pipelines --output text --query "pipelines[$(auto_filter_joined name version -- $FIRST_RESOURCE)].[name]")
select_one Pipeline "$PIPELINES"

PIPELINE=$SELECTED

PIPELINE_EXECUTIONS=$(awscli codepipeline list-pipeline-executions --pipeline-name "$SELECTED" --output text --query "pipelineExecutionSummaries[$(auto_filter_joined pipelineExecutionId -- $SECOND_RESOURCE)].[pipelineExecutionId]")

select_one PipelineExecution "$PIPELINE_EXECUTIONS"

awscli codepipeline get-pipeline-execution --pipeline-name "$PIPELINE" --pipeline-execution-id $SELECTED --output table
split_args "$@"

PIPELINES=$(awscli codepipeline list-pipelines --output text --query "pipelines[$(auto_filter name version -- $FIRST_RESOURCE)].[name]")
select_one Pipeline "$PIPELINES"

awscli codepipeline get-pipeline-state --name $SELECTED --output table --query "stageStates[$(auto_filter stageName -- $SECOND_RESOURCE)]"
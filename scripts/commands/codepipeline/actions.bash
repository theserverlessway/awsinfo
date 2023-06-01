split_args "$@"

PIPELINES=$(awscli codepipeline list-pipelines --output text --query "pipelines[$(auto_filter_joined name version -- "$FIRST_RESOURCE")].[name]")
select_one Pipeline "$PIPELINES"

FILTER=$(auto_filter_joined "join('',actionStates[].actionName||[''])" -- "$SECOND_RESOURCE")

awscli codepipeline get-pipeline-state --name "$SELECTED" --output table --query "stageStates[$FILTER].actionStates[] | [$(auto_filter_joined actionName -- "$SECOND_RESOURCE")]"
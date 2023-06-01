TASK_DEFINITIONS=$(awscli ecs list-task-definitions --output text --query "taskDefinitionArns[$(auto_filter_joined @ -- "$@")].[@]")
select_one TaskDefinition "$TASK_DEFINITIONS"

awscli ecs describe-task-definition --task-definition $SELECTED --output table --include TAGS
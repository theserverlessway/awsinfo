TASK_DEFINITIONS=$(awscli ecs list-task-definitions --output text --query "taskDefinitionArns[$(auto_filter @ -- $@)].[@]")
select_one TaskDefinition "$TASK_DEFINITIONS"

awscli ecs describe-task-definition --task-definition $SELECTED --output table --query "taskDefinition.{ \
    \"1.Family\":family, \
    \"2.Status\":status, \
    \"3.NetworkMode\":networkMode, \
    \"4.Revision\":revision,
    \"5.Fargate CPU/Memory\":join('/', [to_string(cpu||''), to_string(memory||'')]),
    \"6.Containers\":containerDefinitions,
    \"7.Volumes\":volumes,
    \"8.PlacementConstraints\":placementConstraints,
    \"9.Compatibilities\":compatibilities}"

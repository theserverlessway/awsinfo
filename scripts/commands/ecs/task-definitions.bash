awscli ecs list-task-definitions --output table --query "taskDefinitionArns[$(auto_filter_joined @ -- $@)].[@]"

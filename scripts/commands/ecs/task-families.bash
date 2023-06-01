awscli ecs list-task-definition-families --output table --query "families[$(auto_filter_joined @ -- "$@")]"

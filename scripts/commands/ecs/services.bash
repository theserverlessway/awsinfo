split_args "$@"

CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter @ -- $FIRST_RESOURCE)].[@]")
select_one Cluster "$CLUSTERS"

awscli ecs list-services --output table --cluster $SELECTED --query "serviceArns[$(auto_filter @ -- $SECOND_RESOURCE)]"
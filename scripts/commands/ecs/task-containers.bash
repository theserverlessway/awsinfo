split_args "$@"

CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter @ -- $FIRST_RESOURCE)].[@]")
select_one Cluster "$CLUSTERS"

CLUSTER=$SELECTED

TASKS=$(awscli ecs list-tasks --output text --cluster $SELECTED --query taskArns[$(auto_filter @ -- $SECOND_RESOURCE)].[@])
select_one Task "$TASKS"

OUTPUT=$(awscli ecs describe-tasks --tasks $SELECTED --cluster $CLUSTER --query "tasks[].containers" |  sed "s/arn.*\///g")
echo -e $OUTPUT | python $DIR/combine_calls.py TaskContainers

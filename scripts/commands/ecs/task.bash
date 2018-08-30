TASK_STATUS=""

while getopts "s" opt; do
    case "$opt" in
        s) TASK_STATUS="--desired-status STOPPED" ;;
    esac
done
shift $(($OPTIND-1))

split_args "$@"

CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter @ -- $FIRST_RESOURCE)].[@]")
select_one Cluster "$CLUSTERS"

CLUSTER=$SELECTED

TASKS=$(awscli ecs list-tasks --output text --cluster $SELECTED $TASK_STATUS --query taskArns[$(auto_filter @ -- $SECOND_RESOURCE)].[@])
select_one Task "$TASKS"

awscli ecs describe-tasks --tasks $SELECTED --cluster $CLUSTER  --output table --query tasks[0]

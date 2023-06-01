TASK_STATUS=""

while getopts "s" opt; do
    case "$opt" in
        s) TASK_STATUS="--desired-status STOPPED" ;;
    esac
done

# To allow awsinfo ecs tasks -- TASK_FILTER without providing cluster arguments this is necessary
# to check if `--` is used. getopts will jump over `--` by default
if [[ "${@:$OPTIND-1:1}" == "--" ]]; then
  OPTIND=$OPTIND-1
fi

shift $(($OPTIND-1))

split_args "$@"

CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter_joined @ -- "$FIRST_RESOURCE")].[@]")
select_one Cluster "$CLUSTERS"

CLUSTER=$SELECTED

TASKS=$(awscli ecs list-tasks --output text --cluster "$SELECTED" "$TASK_STATUS" --query taskArns[].[@])

FILTER=$(auto_filter_joined taskArn taskDefinitionArn containerInstanceArn lastStatus group cpu memory launchType capacityProviderName -- "$SECOND_RESOURCE")
FILTERED_TASKS=$(echo "$TASKS" | xargs -rn 99 bash -c "awscli ecs describe-tasks --cluster "$SELECTED" --query \"tasks[$FILTER].[taskArn]\" --output text --tasks \$0 \$@")

select_one Task "$FILTERED_TASKS"

awscli ecs describe-tasks --tasks "$SELECTED" --cluster $CLUSTER  --output table --query tasks[0]

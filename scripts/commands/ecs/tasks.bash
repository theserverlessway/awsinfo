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

TASKS=$(awscli ecs list-tasks --output text --cluster $SELECTED $TASK_STATUS --query taskArns)

FILTER=$(auto_filter taskArn taskDefinitionArn containerInstanceArn lastStatus group cpu memory launchType -- $SECOND_RESOURCE)

if [[ ! -z "$TASKS" ]]
then
  OUTPUT=$(awscli ecs describe-tasks --tasks $TASKS --cluster $SELECTED \
    --query "tasks[$FILTER].{ \
      \"1.Task\":taskArn, \
      \"2.Definition\":taskDefinitionArn, \
      \"3.Instance\":containerInstanceArn, \
      \"4.Status\":lastStatus,
      \"5.CPU\":cpu,
      \"6.Memory\":memory
      \"7.Containers\":length(containers),
      \"8.Group\":group,
      \"9.LaunchType\":launchType}" |  sed "s/arn.*\///g")
  echo -e $OUTPUT | python3 $DIR/combine_calls.py DescribeTasks
else
  echo "No Tasks Found"
fi

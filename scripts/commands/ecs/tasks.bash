TASK_STATUS="RUNNING"
TASK_FAMILY=""
TASK_NAME=""
SORT_BY="&to_string(createdAt)"

while getopts "gsf:n:l" opt; do
  case "$opt" in
  g) SORT_BY="&join('-',[taskDefinitionArn,to_string(createdAt)])" ;;
  s) TASK_STATUS="STOPPED" ;;
  f) TASK_FAMILY="$OPTARG" ;;
  n) TASK_NAME="--service-name $OPTARG" ;;
  esac
done

# To allow awsinfo ecs tasks -- TASK_FILTER without providing cluster arguments this is necessary
# to check if `--` is used. getopts will jump over `--` by default
if [[ "${@:$OPTIND-1:1}" == "--" ]]; then
  OPTIND=$OPTIND-1
fi

shift "$(($OPTIND - 1))"

split_args "$@"

if [[ ! -z "$TASK_FAMILY" ]]; then
  FAMILIES=$(awscli ecs list-task-definition-families --output text --query "families[$(auto_filter_joined @ -- $TASK_FAMILY)].[@]" | sort)
  select_one Family "$FAMILIES"
  TASK_FAMILY="--family $SELECTED"
fi

CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter_joined @ -- "$FIRST_RESOURCE")].[@]")
select_one Cluster "$CLUSTERS"

TASKS=$(awscli ecs list-tasks --output text $TASK_FAMILY $TASK_NAME --cluster "$SELECTED" --desired-status "$TASK_STATUS" --query taskArns | sed "s/None//g")
FILTER=$(auto_filter_joined taskArn taskDefinitionArn containerInstanceArn lastStatus group cpu memory launchType capacityProviderName -- "$SECOND_RESOURCE")

FILTERED_TASKS=$(echo "$TASKS" | xargs -rn 99 bash -c "awscli ecs describe-tasks --cluster "$SELECTED" --query \"tasks[$FILTER].taskArn\" --output text --tasks \$0 \$@")

echo "$FILTERED_TASKS" | xargs -rn 99 bash -c "awscli ecs describe-tasks --output json --query \"reverse(sort_by(tasks,$SORT_BY))[].{\\\"1.Task\\\":taskArn,\\\"2.Definition\\\":taskDefinitionArn,\\\"3.Instance\\\":containerInstanceArn,\\\"4.Status/Health\\\":join('/',[lastStatus,healthStatus]),
        \\\"5.CreatedAt\\\":createdAt,\\\"6.CPU/Memory\\\":join('/', [cpu , memory]),\\\"7.Containers\\\":length(containers),\\\"8.Group\\\":group,\\\"9.CapacityProvider\\\":capacityProviderName}\" --cluster "$SELECTED" --tasks \$0 \$@" | sed "s/arn.*\///g" | print_table DescribeTasks

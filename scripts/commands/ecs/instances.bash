INSTANCE_FILTER=""
INSTANCE_FILTER_ARG=""

while getopts "f:" opt; do
    case "$opt" in
        f)
          INSTANCE_FILTER="--filter"
          INSTANCE_FILTER_ARG="$OPTARG"
        ;;
    esac
done
shift $(($OPTIND-1))

split_args "$@"

CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter @ -- $FIRST_RESOURCE)].[@]")
select_one Cluster "$CLUSTERS"

INSTANCES=$(aws ecs list-container-instances --output text --cluster $SELECTED $INSTANCE_FILTER "$INSTANCE_FILTER_ARG" --query containerInstanceArns)

FILTER=$(auto_filter containerInstanceArn ec2InstanceId status "to_string(agentConnected)" "attributes[].value|[0]||''" -- $SECOND_RESOURCE)

if [[ ! -z "$INSTANCES" ]]
then
  awscli ecs describe-container-instances --container-instances $INSTANCES --cluster $SELECTED  --output table \
    --query "containerInstances[$FILTER].{ \
      \"1.Arn\":containerInstanceArn, \
      \"2.InstanceId\":ec2InstanceId, \
      \"3.Status\":status, \
      \"4.AgentConnected\":agentConnected, \
      \"5.Running/Pending\":join('/', [to_string(runningTasksCount), to_string(pendingTasksCount)]),\
      \"6.AgentConnected\":agentConnected,
      \"7.CPU available\":join(' of ', [to_string(remainingResources[?name=='CPU'].integerValue|[0]), to_string(registeredResources[?name=='CPU'].integerValue|[0])]), \
      \"8.Memory available\":join(' of ', [to_string(remainingResources[?name=='MEMORY'].integerValue|[0]), to_string(registeredResources[?name=='MEMORY'].integerValue|[0])]), \
      \"9.AgentVersion\":versionInfo.agentVersion}"
else
  echo "No Instances Found"
fi

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

CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter_joined @ -- $FIRST_RESOURCE)].[@]")
select_one Cluster "$CLUSTERS"

CLUSTER=$SELECTED

INSTANCES=$(awscli ecs list-container-instances --output text --cluster $SELECTED $INSTANCE_FILTER "$INSTANCE_FILTER_ARG" --query "containerInstanceArns[$(auto_filter_joined @ -- $SECOND_RESOURCE)].[@]")

select_one Instance "$INSTANCES"

awscli ecs describe-container-instances --container-instances $SELECTED --cluster $CLUSTER  --output table \
  --query "containerInstances[].{ \
    \"1.Arn\":containerInstanceArn, \
    \"2.InstanceId\":ec2InstanceId, \
    \"3.Status\":status, \
    \"4.AgentConnected\":agentConnected, \
    \"5.Running/Pending\":join('/', [to_string(runningTasksCount), to_string(pendingTasksCount)]),\
    \"6.AgentConnected\":agentConnected, \
    \"7.CPU available\":join(' of ', [to_string(remainingResources[?name=='CPU'].integerValue|[0]), to_string(registeredResources[?name=='CPU'].integerValue|[0])]), \
    \"8.Memory available\":join(' of ', [to_string(remainingResources[?name=='MEMORY'].integerValue|[0]), to_string(registeredResources[?name=='MEMORY'].integerValue|[0])]), \
    \"9.Ports\":remainingResources[?name=='PORTS'].stringSetValue, \
    \"VersionInfo\":versionInfo, \
    \"Attributes\":attributes,
    \"Attachments\":attachments}"

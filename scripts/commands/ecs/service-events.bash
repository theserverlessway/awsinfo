split_args "$@"

CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter_joined @ -- "$FIRST_RESOURCE")].[@]")
select_one Cluster "$CLUSTERS"

CLUSTER=$SELECTED

SERVICES=$(awscli ecs list-services --cluster $CLUSTER --output text --query "serviceArns[$(auto_filter_joined @ -- "$SECOND_RESOURCE")].[@]")
select_one Service "$SERVICES"

awscli ecs describe-services --cluster $CLUSTER --services $SELECTED --output table --query "services[0].events[].{
    \"1.Timestamp\":createdAt,
    \"2.Message\":message}"
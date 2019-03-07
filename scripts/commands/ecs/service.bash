split_args "$@"

CLUSTERS=$(awscli ecs list-clusters --output text --query "clusterArns[$(auto_filter @ -- $FIRST_RESOURCE)].[@]")
select_one Cluster "$CLUSTERS"

CLUSTER=$SELECTED

SERVICES=$(awscli ecs list-services --cluster $CLUSTER --output text --query "serviceArns[$(auto_filter @ -- $SECOND_RESOURCE)].[@]")
select_one Service "$SERVICES"

awscli ecs describe-services --cluster $CLUSTER --services $SELECTED --query "services[0]"| jq -Mcr 'del(.events)' | python3 $DIR/combine_calls.py DescribeService
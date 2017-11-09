split_args "$@"

STACK_LISTING=$(awscli cloudformation describe-stacks --output text --query "sort_by(Stacks,&StackName)[$(filter StackName $FIRST_RESOURCE)].[StackName]")
select_one Stack "$STACK_LISTING"

FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_LOGICAL_ID+=$(filter_query "LogicalResourceId" $SECOND_RESOURCE)
    FILTER_PHYSICAL_RESOURCE+=$(filter_query "PhysicalResourceId" $SECOND_RESOURCE)
    FILTER_RESOURCE_TYPE+=$(filter_query "ResourceType" $SECOND_RESOURCE)


    FILTER_QUERY="?$(join "||" $FILTER_LOGICAL_ID $FILTER_PHYSICAL_RESOURCE $FILTER_RESOURCE_TYPE)"
fi

awscli cloudformation list-stack-resources --stack-name $SELECTED --output table --query "StackResourceSummaries[$FILTER_QUERY].{\"1.LogicalId\":LogicalResourceId,\"2.PhysicalId\":PhysicalResourceId,\"3.Type\":ResourceType\"4.Status\":ResourceStatus,\"5.LastUpdated\":LastUpdatedTimestamp}"
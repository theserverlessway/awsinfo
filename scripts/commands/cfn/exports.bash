FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_STACK_ID+=$(filter_query "ExportingStackId" $@)
    FILTER_NAME+=$(filter_query "Name" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_STACK_ID)"
fi

awscli cloudformation list-exports --output table --query "Exports[$FILTER_QUERY].{\"1.Name\":Name,\"2.Value\":Value}"
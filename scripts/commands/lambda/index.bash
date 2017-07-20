FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "FunctionName" $@)
    FILTER_RUNTIME+=$(filter_query "Runtime" $@)
    FILTER_MEMORYSIZE+=$(filter_query "to_string(MemorySize)" $@)
    FILTER_TIMEOUT+=$(filter_query "to_string(Timeout)" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_RUNTIME $FILTER_MEMORYSIZE $FILTER_TIMEOUT)"
fi

awscli lambda list-functions --output table --query "Functions[$FILTER_QUERY].{\"1.Name\":FunctionName,\"2.Runtime\":Runtime,\"3.Timeout\":Timeout,\"4.MemorySize\":MemorySize}"


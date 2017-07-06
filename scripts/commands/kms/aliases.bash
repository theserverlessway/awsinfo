FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_KEY_ID+=$(filter_query "(TargetKeyId||'')" $@)
    FILTER_NAME+=$(filter_query "AliasName" $@)

    FILTER_QUERY="?$(join "||" $FILTER_KEY_ID $FILTER_NAME)"
fi

awscli kms list-aliases --output table --query "Aliases[$FILTER_QUERY].{\"1.Name\": AliasName, \"2.Key\": TargetKeyId||'', \"3.AliasArn\": AliasArn}"
FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "PolicyName" $@)
    FILTER_ID+=$(filter_query "PolicyId" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID)"
fi

awscli iam list-policies --scope Local --output table --query "Policies[$FILTER_QUERY].{\"1.Name\":PolicyName,\"2.Id\":PolicyId,\"AttachedTo\":AttachmentCount\"4.Arn\":Arn}"
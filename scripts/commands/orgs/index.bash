FILTER_QUERY=""

if [[ $# -gt 0 ]]; then
    FILTER_NAME+=$(filter_query "Name" $@)
    FILTER_ID+=$(filter_query "Id" $@)
    FILTER_STATUS+=$(filter_query "Status" $@)
    FILTER_EMAIL+=$(filter_query "Email" $@)

    FILTER_QUERY="?$(join "||" $FILTER_NAME $FILTER_ID $FILTER_STATUS $FILTER_EMAIL)"
fi

awscli organizations list-accounts --output table --query "sort_by(Accounts,&Name)[$FILTER_QUERY].{\"1.Name\":Name,\"2.Id\":Id,\"3.Status\":Status,\"4.Email\":Email}"
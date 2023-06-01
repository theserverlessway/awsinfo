split_args "$@"

FILTER=$(auto_filter_joined ApiId Name ApiEndpoint Description ProtocolType -- $FIRST_RESOURCE)

APIS_LISTING=$(awscli apigatewayv2 get-apis --output text --query "Items[$FILTER].[ApiId]")
select_one API "$APIS_LISTING"

SELECTED_API=$SELECTED
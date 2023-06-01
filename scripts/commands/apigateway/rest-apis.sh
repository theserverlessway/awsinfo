split_args "$@"

FILTER=$(auto_filter_joined id name "join('',endpointConfiguration.types)" -- "$FIRST_RESOURCE")

REST_APIS_LISTING=$(awscli apigateway get-rest-apis --output text --query "sort_by(items,&name)[$FILTER].[id]")
select_one RestAPI "$REST_APIS_LISTING"

SELECTED_REST_API=$SELECTED
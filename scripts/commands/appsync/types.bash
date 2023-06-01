split_args "$@"

APIS=$(awscli appsync list-graphql-apis --output text --query "sort_by(graphqlApis,&name)[$(auto_filter_joined name apiId authenticationType uris.GRAPHQL -- "$FIRST_RESOURCE")].[apiId]")
select_one APIS "$APIS"

awscli appsync list-types --api-id $SELECTED --format json --output table --query "sort_by(types,&name)[$(auto_filter_joined name -- "$SECOND_RESOURCE")].{
  \"1.Name\":name}"

split_args "$@"

APIS=$(awscli appsync list-graphql-apis --output text --query "sort_by(graphqlApis,&name)[$(auto_filter_joined name apiId authenticationType uris.GRAPHQL -- "$FIRST_RESOURCE")].[apiId]")
select_one Api "$APIS"

SELECTED_API=$SELECTED

TYPES=$(awscli appsync list-types --api-id $SELECTED --format json --output text --query "sort_by(types,&name)[$(auto_filter_joined name -- "$SECOND_RESOURCE")].[name]")
select_one Type "$TYPES"

awscli appsync list-resolvers --api-id $SELECTED_API --type-name $SELECTED --output table --query "sort_by(resolvers,&typeName)[].{
  \"1.Type\":typeName,
  \"2.Field\":fieldName,
  \"3.DataSource\":dataSourceName}"

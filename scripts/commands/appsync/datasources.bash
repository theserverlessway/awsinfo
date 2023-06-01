split_args "$@"

APIS=$(awscli appsync list-graphql-apis --output text --query "sort_by(graphqlApis,&name)[$(auto_filter_joined name apiId authenticationType uris.GRAPHQL -- $FIRST_RESOURCE)].[apiId]")
select_one APIS "$APIS"

awscli appsync list-data-sources --api-id $SELECTED --output table --query "sort_by(dataSources,&name)[$(auto_filter_joined name type serviceRoleArn dynamodbConfig.tableName -- $SECOND_RESOURCE)].{
  \"1.Name\":name,
  \"2.Type\":type,
  \"3.Config\":dynamodbConfig||lambdaConfig||elasticsearchConfig}"

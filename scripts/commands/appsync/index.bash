awscli appsync list-graphql-apis --output table --query "sort_by(graphqlApis,&name)[$(auto_filter_joined name apiId authenticationType uris.GRAPHQL -- "$@")].{
  \"1.Name\":name,
  \"2.Id\":apiId,
  \"3.Auth\": authenticationType,
  \"4.URI\":uris.GRAPHQL}"
APIS=$(awscli appsync list-graphql-apis --output text --query "sort_by(graphqlApis,&name)[$(auto_filter_joined name apiId authenticationType uris.GRAPHQL -- "$@")].[apiId]")
select_one APIS "$APIS"

awscli appsync get-introspection-schema --api-id "$SELECTED" --format SDL /dev/stdout

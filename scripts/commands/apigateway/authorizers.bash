source $CURRENT_COMMAND_DIR/rest-apis.sh

FILTER=$(auto_filter_joined name authorizerUri identitySource type id  -- $SECOND_RESOURCE)

awscli apigateway get-authorizers --rest-api-id $SELECTED --output table --query "sort_by(items,&name)[$FILTER].{
  \"1.Id\":Id,
  \"2.Name\":name,
  \"3.IdentitySource\":identitySource,
  \"4.Type\":type,
  \"5.TTL\":authorizerResultTtlInSeconds,
  \"6.Uri\":authorizerUri}"

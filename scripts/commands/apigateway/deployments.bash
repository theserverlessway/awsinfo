source $CURRENT_COMMAND_DIR/rest-apis.sh

FILTER=$(auto_filter_joined description id  -- $SECOND_RESOURCE)

awscli apigateway get-deployments --rest-api-id $SELECTED --output table --query "items[$FILTER].{
  \"1.Id\":id,
  \"2.Description\":description||'',
  \"3.CreatedDate\":createdDate}"

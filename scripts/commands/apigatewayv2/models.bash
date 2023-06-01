source $CURRENT_COMMAND_DIR/apis.sh

FILTER=$(auto_filter_joined ModelId Name Description ContentType -- "$SECOND_RESOURCE")

awscli apigatewayv2 get-models --api-id $SELECTED --output table --query "Items[$FILTER].{
  \"1.Id\":ModelId,
  \"2.Name\":Name,
  \"3.Description\":Description,
  \"4.ContentType\":ContentType}"

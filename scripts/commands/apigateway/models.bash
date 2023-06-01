source $CURRENT_COMMAND_DIR/rest-apis.sh

FILTER=$(auto_filter_joined id name description contentType  -- "$SECOND_RESOURCE")

awscli apigateway get-models --rest-api-id "$SELECTED" --output table --query "items[$FILTER].{
  \"1.Id\":id,
  \"2.Name\":name,
  \"3.Description\":description,
  \"4.ContentType\":contentType}"

source $CURRENT_COMMAND_DIR/apis.sh

FILTER=$(auto_filter_joined RouteId RouteKey Target ApiKeyRequired AuthorizationType -- "$SECOND_RESOURCE")

awscli apigatewayv2 get-routes --api-id "$SELECTED" --output table --query "Items[$FILTER].{
  \"1.Id\":RouteId,
  \"2.RouteKey\":RouteKey,
  \"3.Target\":Target,
  \"4.ApiKeyRequired\":ApiKeyRequired,
  \"5.AuthorizationType\":AuthorizationType}"

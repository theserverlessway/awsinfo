source $CURRENT_COMMAND_DIR/apis.sh

FILTER=$(auto_filter_joined RouteId RouteKey Target ApiKeyRequired AuthorizationType -- "$SECOND_RESOURCE")

ROUTES_LIST=$(awscli apigatewayv2 get-routes --api-id "$SELECTED" --output text --query "Items[$FILTER].[RouteId]")

select_one Route "$ROUTES_LIST"

awscli apigatewayv2 get-route-responses --api-id "$SELECTED_API" --route-id "$SELECTED" --output table
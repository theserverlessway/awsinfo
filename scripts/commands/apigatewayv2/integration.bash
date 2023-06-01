source $CURRENT_COMMAND_DIR/apis.sh

FILTER=$(auto_filter_joined IntegrationId IntegrationMethod IntegrationType ConnectionType Description -- "$SECOND_RESOURCE")

INTEGRATIONS_LIST=$(awscli apigatewayv2 get-integrations --api-id "$SELECTED" --output text --query "Items[$FILTER].[IntegrationId]")

select_one Integration "$INTEGRATIONS_LIST"

awscli apigatewayv2 get-integration --api-id "$SELECTED_API" --integration-id "$SELECTED" --output table
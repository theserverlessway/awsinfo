source $CURRENT_COMMAND_DIR/apis.sh

FILTER=$(auto_filter_joined IntegrationId IntegrationMethod IntegrationType ConnectionType Description -- $SECOND_RESOURCE)

awscli apigatewayv2 get-integrations --api-id $SELECTED --output table --query "Items[$FILTER].{
  \"1.Id\":IntegrationId,
  \"2.Method\":IntegrationMethod,
  \"3.Type\":IntegrationType,
  \"4.ConnectionType\":ConnectionType,
  \"5.Description\":Description}"

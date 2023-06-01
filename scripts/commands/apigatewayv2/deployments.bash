source $CURRENT_COMMAND_DIR/apis.sh

FILTER=$(auto_filter_joined DeploymentId DeploymentStatus Description AutoDeployed  -- "$SECOND_RESOURCE")

awscli apigatewayv2 get-deployments --api-id $SELECTED --output table --query "Items[$FILTER].{
  \"1.Id\":DeploymentId,
  \"2.DeploymentStatus\":DeploymentStatus,
  \"3.CreatedDate\":CreatedDate,
  \"4.Description\":Description||'',
  \"5.AutoDeployed\":AutoDeployed}"

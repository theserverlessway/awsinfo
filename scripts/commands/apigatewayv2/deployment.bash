source $CURRENT_COMMAND_DIR/apis.sh

FILTER=$(auto_filter_joined DeploymentId DeploymentStatus Description AutoDeployed -- $SECOND_RESOURCE)

DEPLOYMENTS_LIST=$(awscli apigatewayv2 get-deployments --api-id $SELECTED --output text --query "Items[$FILTER].[DeploymentId]")

select_one Deployment "$DEPLOYMENTS_LIST"

awscli apigatewayv2 get-deployment --api-id "$SELECTED_API" --deployment-id "$SELECTED" --output table
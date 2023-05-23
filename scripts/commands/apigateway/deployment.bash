source $CURRENT_COMMAND_DIR/rest-apis.sh

FILTER=$(auto_filter_joined description id  -- $SECOND_RESOURCE)

DEPLOYMENTS_LIST=$(awscli apigateway get-deployments --rest-api-id $SELECTED --output text --query "items[$FILTER].[id]")

select_one Deployment $DEPLOYMENTS_LIST

awscli apigateway get-deployment --rest-api-id "$SELECTED_REST_API" --deployment-id "$SELECTED" --output table --embed apisummary
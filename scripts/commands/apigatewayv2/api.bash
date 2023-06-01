source $CURRENT_COMMAND_DIR/apis.sh

awscli apigatewayv2 get-api --api-id $SELECTED_API --output table
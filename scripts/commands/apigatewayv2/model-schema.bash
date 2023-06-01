source $CURRENT_COMMAND_DIR/apis.sh

FILTER=$(auto_filter_joined ModelId Name Description ContentType  -- "$SECOND_RESOURCE")

MODELS_LIST=$(awscli apigatewayv2 get-models --api-id "$SELECTED" --output text --query "items[$FILTER].[ModelId]")

select_one Model "$MODELS_LIST"

awscli apigatewayv2 get-model --api-id "$SELECTED_API" --model-id "$SELECTED" --output text --query schema
source $CURRENT_COMMAND_DIR/rest-apis.sh

FILTER=$(auto_filter_joined id name description contentType  -- $SECOND_RESOURCE)

MODELS_LIST=$(awscli apigateway get-models --rest-api-id $SELECTED --output text --query "items[$FILTER].[name]")

select_one Model "$MODELS_LIST"

awscli apigateway get-model --rest-api-id "$SELECTED_REST_API" --model-name "$SELECTED" --output text --query schema
source $CURRENT_COMMAND_DIR/rest-apis.sh

FILTER=$(auto_filter_joined responseType statusCode "to_string(defaultResponse)" -- $SECOND_RESOURCE)

awscli apigateway get-gateway-responses --rest-api-id $SELECTED_REST_API --output table --query "sort_by(items,&to_string(statusCode))[$FILTER]"
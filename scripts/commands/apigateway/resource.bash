source $CURRENT_COMMAND_DIR/rest-apis.sh

FILTER=$(auto_filter_joined path id parentId  -- "$SECOND_RESOURCE")
RESOURCE_LIST=$(awscli apigateway get-resources --rest-api-id $SELECTED --output text --query "sort_by(items,&path)[$FILTER].[id]")

select_one Resource $RESOURCE_LIST

awscli apigateway get-resource --rest-api-id $SELECTED_REST_API --resource-id $SELECTED --output table --embed methods
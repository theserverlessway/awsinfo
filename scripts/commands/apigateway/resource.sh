source $CURRENT_COMMAND_DIR/rest-apis.sh

FILTER=$(auto_filter_joined path id parentId "join('',keys(resourceMethods||{Miss:''}))"  -- "$SECOND_RESOURCE")

RESOURCE_LIST=$(awscli apigateway get-resources --rest-api-id "$SELECTED" --output text --query "sort_by(items,&path)[$FILTER].[id]")

select_one Resource "$RESOURCE_LIST"

SELECTED_RESOURCE="$SELECTED"
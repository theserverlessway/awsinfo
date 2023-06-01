source $CURRENT_COMMAND_DIR/apis.sh

API_STAGE_LISTINGS=$(awscli apigatewayv2 get-stages --api-id $SELECTED_API --output text --query "sort_by(Items,&StageName)[$(auto_filter_joined StageName DeploymentId -- "$SECOND_RESOURCE")].[StageName]")
select_one Stage "$API_STAGE_LISTINGS"

awscli apigatewayv2 get-stage --api-id "$SELECTED_API" --stage-name "$SELECTED" --output table
source $CURRENT_COMMAND_DIR/rest-apis.sh

REST_API_ID="$SELECTED"

REST_API_STAGE_LISTINGS=$(awscli apigateway get-stages --rest-api-id $REST_API_ID --output text --query "sort_by(item,&stageName)[$(auto_filter_joined deploymentId stageName -- "$SECOND_RESOURCE")].[stageName]")
select_one Stage "$REST_API_STAGE_LISTINGS"

awscli apigateway get-stage --rest-api-id "$REST_API_ID" --stage-name "$SELECTED" --output table
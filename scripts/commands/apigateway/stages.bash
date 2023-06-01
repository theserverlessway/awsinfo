source $CURRENT_COMMAND_DIR/rest-apis.sh

awscli apigateway get-stages --rest-api-id "$SELECTED" --output table --query "sort_by(item,&stageName)[$(auto_filter_joined deploymentId stageName -- "$SECOND_RESOURCE")].{
  \"1.Name\":stageName,
  \"2.DeploymentId\":deploymentId}"

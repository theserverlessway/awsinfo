source $CURRENT_COMMAND_DIR/apis.sh

awscli apigatewayv2 get-stages --api-id $SELECTED --output table --query "sort_by(Items,&StageName)[$(auto_filter_joined StageName DeploymentId -- $SECOND_RESOURCE)].{
  \"1.Name\":StageName,
  \"2.DeploymentId\":DeploymentId,
  \"3.AutoDeploy\":AutoDeploy,
  \"4.LastUpdatedDate\":LastUpdatedDate}"

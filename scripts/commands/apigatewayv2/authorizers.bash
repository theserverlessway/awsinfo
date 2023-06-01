source $CURRENT_COMMAND_DIR/apis.sh

FILTER=$(auto_filter_joined Name AuthorizerId AuthorizerType -- $SECOND_RESOURCE)

awscli apigatewayv2 get-authorizers --api-id $SELECTED --output table --query "sort_by(Items,&Name)[$FILTER].{
  \"1.Id\":AuthorizerId,
  \"2.Name\":Name,
  \"3.AuthorizerType\":AuthorizerType}"

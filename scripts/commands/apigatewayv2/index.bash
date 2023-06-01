FILTER=$(auto_filter_joined ApiId Name ApiEndpoint Description ProtocolType -- "$@")
awscli apigatewayv2 get-apis --output table --query "sort_by(Items,&Name)[$FILTER].{
  \"1.Name\":Name,
  \"2.Id\":ApiId,
  \"3.Description\": Description,
  \"4.Protocol\":ProtocolType,
  \"6.ApiEndpoint\":ApiEndpoint}"
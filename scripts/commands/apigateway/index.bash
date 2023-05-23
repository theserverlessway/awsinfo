# Example of a Simple Command

FILTER=$(auto_filter_joined id name "join('',endpointConfiguration.types)" -- $@)
awscli apigateway get-rest-apis --output table --query "sort_by(items,&name)[$FILTER].{
  \"1.Name\":name,
  \"2.Id\":id,
  \"3.Description\": description,
  \"4.Created\":createdDate,
  \"5.APIKeySource\":apiKeySource,
  \"6.EndpointTypes\":join('',endpointConfiguration.types)}"
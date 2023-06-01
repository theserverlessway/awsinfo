awscli apigateway get-client-certificates --output table --query "items[$(auto_filter_joined clientCertificateId description -- $@)].{
  \"1.Id\":clientCertificateId,
  \"2.Description\":description,
  \"3.CreatedAt\": createdDate,
  \"4.ExpiresAt\":expirationDate}"

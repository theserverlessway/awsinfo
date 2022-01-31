awscli iam list-saml-providers --output table --query "sort_by(SAMLProviderList,&Arn)[$(auto_filter Arn -- $@)].{
  \"1.Arn\":Arn,
  \"2.CreateDate\":CreateDate,
  \"3.ValidUntil\": ValidUntil}"
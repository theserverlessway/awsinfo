awscli iam list-saml-providers --output table --query "sort_by(SAMLProviderList,&Arn)[$(auto_filter_joined Arn -- $@)].{
  \"1.Arn\":Arn,
  \"2.CreateDate\":CreateDate,
  \"3.ValidUntil\": ValidUntil}"
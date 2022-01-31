PROVIDER_LISTING=$(awscli iam list-saml-providers --output text --query "sort_by(SAMLProviderList,&Arn)[$(auto_filter Arn -- $@)].[Arn]")
select_one Stack "$PROVIDER_LISTING"

awscli iam get-saml-provider --saml-provider-arn $SELECTED --output text --query SAMLMetadataDocument
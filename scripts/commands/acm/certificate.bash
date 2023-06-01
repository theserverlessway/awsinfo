CERTIFICATE_LIST=$(awscli acm list-certificates --output text --query "CertificateSummaryList[$(auto_filter_joined DomainName CertificateArn -- $@)].[CertificateArn]")

select_one Certificate "$CERTIFICATE_LIST"

awscli acm describe-certificate --certificate-arn $SELECTED --output table --query "Certificate"
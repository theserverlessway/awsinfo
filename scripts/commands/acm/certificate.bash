CERTIFICATE_LIST=$(awscli acm list-certificates --output text --query "CertificateSummaryList[$(auto_filter DomainName -- $@)].[CertificateArn]")

select_one Certificate "$CERTIFICATE_LIST"

awscli acm describe-certificate --certificate-arn $SELECTED --output table --query "Certificate"
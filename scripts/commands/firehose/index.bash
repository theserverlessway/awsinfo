awscli firehose list-delivery-streams --limit 5000 --output table --query "DeliveryStreamNames[$(auto_filter @ -- $@)]"

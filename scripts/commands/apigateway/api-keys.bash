awscli apigateway get-api-keys --output table --query "sort_by(items,&name)[$(auto_filter_joined name description id -- $@)]"
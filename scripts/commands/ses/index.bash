awscli ses list-identities --output table --query "Identities[$(auto_filter_joined @ -- $@)]"
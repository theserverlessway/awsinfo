SECRET_LISTING=$(awscli secretsmanager list-secrets --output text --query "SecretList[$(auto_filter ARN Name -- $@)].[Name]")
select_one Secret "$SECRET_LISTING"

awscli secretsmanager get-secret-value --secret-id $SELECTED --output text --query "SecretString"

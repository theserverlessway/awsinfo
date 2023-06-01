SECRET_LISTING=$(awscli secretsmanager list-secrets --output text --query "SecretList[$(auto_filter_joined ARN Name -- "$@")].[Name]")
select_one Secret "$SECRET_LISTING"

awscli secretsmanager describe-secret --secret-id "$SELECTED" --output table

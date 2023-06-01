awscli secretsmanager list-secrets --output table \
  --query "SecretList[$(auto_filter_joined ARN Name -- $@)].{ \
    \"1.Name\":Name, \
    \"2.ARN\":ARN}"

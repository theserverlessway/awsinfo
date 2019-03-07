awscli secretsmanager list-secrets --output table \
  --query "SecretList[$(auto_filter ARN Name -- $@)].{ \
    \"1.Name\":Name, \
    \"2.ARN\":ARN}"

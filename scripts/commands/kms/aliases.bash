FILTER=$(auto_filter "(TargetKeyId||'')" AliasName -- $@)

awscli kms list-aliases --output table --query "Aliases[$FILTER].{\"1.Name\": AliasName, \"2.Key\": TargetKeyId||'', \"3.AliasArn\": AliasArn}"
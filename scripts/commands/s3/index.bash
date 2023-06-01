awscli s3api list-buckets --output table \
  --query "(Buckets[$(auto_filter_joined Name -- "$@")].{ \
    \"1.Name\":Name, \
    \"2.CreationDate\":CreationDate})"

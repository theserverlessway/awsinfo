BUCKET_LISTING=$(awscli s3api list-buckets --output text --query "sort_by(Buckets,&Name)[$(auto_filter Name -- $@)].[Name]")
select_one Bucket "$BUCKET_LISTING"

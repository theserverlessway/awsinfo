split_args "$@"

KEYS=$(awscli kms list-keys --output text --query "sort_by(Keys,&KeyArn)[$(auto_filter_joined KeyArn -- "$FIRST_RESOURCE")].[KeyArn]")

select_one Key "$KEYS"

awscli kms list-key-policies --key-id "$SELECTED" --output table --query "PolicyNames[$(auto_filter_joined @ -- "$SECOND_RESOURCE")]"

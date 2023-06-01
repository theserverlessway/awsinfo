split_args "$@"

KEYS=$(awscli kms list-keys --output text --query "sort_by(Keys,&KeyArn)[$(auto_filter_joined KeyArn -- "$FIRST_RESOURCE")].[KeyArn]")

select_one Key "$KEYS"

KMS_KEY=$SELECTED

POLICIES=$(awscli kms list-key-policies --key-id $SELECTED --output text --query "PolicyNames[$(auto_filter_joined @ -- "$SECOND_RESOURCE")].[@]")

select_one Policy "$POLICIES"

awscli kms get-key-policy --key-id $KMS_KEY --policy-name $SELECTED --query Policy --output text
source $CURRENT_COMMAND_DIR/bucket_listing.sh

awscli s3api get-bucket-policy --bucket "$SELECTED" --output text --query Policy | jq

source $CURRENT_COMMAND_DIR/bucket_listing.sh

awscli s3api get-bucket-encryption --bucket "$SELECTED" --output table

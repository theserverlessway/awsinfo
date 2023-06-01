source $CURRENT_COMMAND_DIR/bucket_listing.sh

awscli s3api get-bucket-lifecycle-configuration --bucket "$SELECTED" --output table

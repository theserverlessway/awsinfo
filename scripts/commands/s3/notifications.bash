source $CURRENT_COMMAND_DIR/bucket_listing.sh

awscli s3api get-bucket-notification-configuration --bucket $SELECTED --output table

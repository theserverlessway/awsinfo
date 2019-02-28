source $CURRENT_COMMAND_DIR/bucket_listing.sh

awscli s3api get-bucket-location --bucket $SELECTED --output table

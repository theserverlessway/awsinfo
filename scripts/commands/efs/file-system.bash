split_args "$@"

FILE_SYSTEM_LISTING=$(awscli efs describe-file-systems --output text --query "sort_by(FileSystems,&FileSystemId)[$(auto_filter_joined FileSystemId -- "$FIRST_RESOURCE")].[FileSystemId]")
select_one Stack "$FILE_SYSTEM_LISTING"

awscli efs describe-file-systems --file-system-id $SELECTED --output table \
  --query "FileSystems[0]"

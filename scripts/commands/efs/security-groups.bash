split_args "$@"

FILE_SYSTEMS=$(awscli efs describe-file-systems --output text --query "FileSystems[$(auto_filter_joined FileSystemId LifeCycleState Name PerformanceMode ThroughputMode 'to_string(Encrypted)' -- "$FIRST_RESOURCE")].[FileSystemId]")
select_one FileSystem "$FILE_SYSTEMS"

FILE_SYSTEM=$SELECTED

MOUNT_TARGETS=$(awscli efs describe-mount-targets --file-system-id $SELECTED --output text \
  --query "MountTargets[$(auto_filter_joined MountTargetId SubnetId LifeCycleState IpAddress NetworkInterfaceId -- "$SECOND_RESOURCE")].[MountTargetId]")
select_one MountTarget "$MOUNT_TARGETS"

awscli efs describe-mount-target-security-groups --mount-target-id $SELECTED --output table --query SecurityGroups

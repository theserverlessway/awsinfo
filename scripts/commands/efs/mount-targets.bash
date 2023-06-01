split_args "$@"

FILE_SYSTEMS=$(awscli efs describe-file-systems --output text --query "FileSystems[$(auto_filter_joined FileSystemId LifeCycleState Name PerformanceMode ThroughputMode 'to_string(Encrypted)' -- "$FIRST_RESOURCE")].[FileSystemId]")
select_one FileSystem "$FILE_SYSTEMS"

awscli efs describe-mount-targets --file-system-id "$SELECTED" --output table \
  --query "MountTargets[$(auto_filter_joined MountTargetId SubnetId LifeCycleState IpAddress NetworkInterfaceId -- "$SECOND_RESOURCE")].{ \
    \"1.Id\":MountTargetId, \
    \"2.FileSystem\":FileSystemId, \
    \"3.State\":LifeCycleState, \
    \"4.Subnet\":SubnetId, \
    \"5.IpAddress\":IpAddress, \
    \"6.NetworkInterface\":NetworkInterfaceId}"

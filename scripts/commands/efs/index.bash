awscli efs describe-file-systems --output table \
  --query "FileSystems[$(auto_filter_joined FileSystemId LifeCycleState Name PerformanceMode ThroughputMode 'to_string(Encrypted)' -- "$@")].{ \
    \"1.Id\":FileSystemId, \
    \"2.Name\":Name, \
    \"3.State\":LifeCycleState, \
    \"4.SizeInBytes\":SizeInBytes.Value, \
    \"5.MountTargets\":NumberOfMountTargets, \
    \"6.PerformanceMode\":PerformanceMode, \
    \"7.Encrypted\":to_string(Encrypted), \
    \"8.ThroughputMode\":ThroughputMode}"

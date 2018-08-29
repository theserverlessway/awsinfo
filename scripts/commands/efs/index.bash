awscli efs describe-file-systems --output table \
  --query "FileSystems[$(auto_filter FileSystemId LifeCycleState Name PerformanceMode ThroughputMode 'to_string(Encrypted)' -- $@)].{ \
    \"1.Id\":FileSystemId, \
    \"2.Name\":Name, \
    \"3.State\":LifeCycleState, \
    \"4.MountTargets\":NumberOfMountTargets, \
    \"5.PerformanceMode\":PerformanceMode, \
    \"6.Encrypted\":to_string(Encrypted), \
    \"7.ThroughputMode\":ThroughputMode}"

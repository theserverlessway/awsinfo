awscli ssm describe-instance-information --output table --query "InstanceInformationList[$(auto_filter_joined InstanceId PlatformType PlatformName PlatformVersion AgentVersion PingStatus -- "$@")].{
  \"1.Id\":InstanceId,
  \"2.Ping Status/LastPing\":join(':',[PingStatus,LastPingDateTime]),
  \"3.AgentVersion/Latest\":join('/',[AgentVersion,to_string(IsLatestVersion)]),
  \"4.Platform\":join('/',[PlatformType,PlatformName,PlatformVersion]),
  \"5.ResourceType\":ResourceType,
  \"6.IPAddress\":IPAddress}"
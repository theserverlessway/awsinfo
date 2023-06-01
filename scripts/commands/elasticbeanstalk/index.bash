awscli elasticbeanstalk describe-environments --output table --query "sort_by(Environments,&join('-',[ApplicationName, EnvironmentName])) \
  [$(auto_filter_joined ApplicationName EnvironmentName Status Health EnvironmentId CNAME -- "$@")].{ \
  \"1.ApplicationName\":ApplicationName, \
  \"2.EnvironmentName\":EnvironmentName, \
  \"3.Status\":Status,  \
  \"4.Health\":Health,  \
  \"5.EnvironmentId\":EnvironmentId,  \
  \"6.CNAME\":CNAME}"
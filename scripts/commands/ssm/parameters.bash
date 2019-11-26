awscli ssm describe-parameters --output table --query "sort_by(Parameters,&Name)[$(auto_filter Name LastModifiedUser Type -- $@)].{
  \"1.Name\":Name,
  \"2.Type\":Type,
  \"3.Version\":Version,
  \"4.LastModifiedUser\":LastModifiedUser}"
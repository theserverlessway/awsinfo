FUNCTION_LISTING=$(awscli lambda list-functions --output text --query "sort_by(Functions,&FunctionName)[$(auto_filter_joined FunctionName -- "$@")].[FunctionName]")
select_one Function "$FUNCTION_LISTING"

awscli lambda list-versions-by-function --function-name "$SELECTED" --output table --query "Versions[-10:].{
  \"1.Name\":FunctionName,
  \"2.Version\":Version,
  \"3.Runtime\":Runtime,
  \"4.Timeout\":Timeout,
  \"5.MemorySize\":MemorySize,
  \"6.Handler\":Handler,
  \"7.ARN\":FunctionArn}"
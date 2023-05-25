source $CURRENT_COMMAND_DIR/rest-apis.sh

FILTER=$(auto_filter_joined path id parentId "join('',keys(resourceMethods||{Miss:''}))"  -- $SECOND_RESOURCE)

awscli apigateway get-resources --rest-api-id $SELECTED --output table --query "sort_by(items,&path)[$FILTER].{
  \"1.Path\":path,
  \"2.Id\":id,
  \"3.ParentId\":parentId||'',
  \"4.PathPart\":pathPart||'',
  \"5.Methods\":join(', 'keys(resourceMethods||{Miss: ''}))}" | sed 's/ Miss /      /g'



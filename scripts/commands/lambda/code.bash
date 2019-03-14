FUNCTION_LISTING=$(awscli lambda list-functions --output text --query "sort_by(Functions,&FunctionName)[$(auto_filter FunctionName -- $@)].[FunctionName]")
select_one Function "$FUNCTION_LISTING"

awscli lambda get-function --function-name $SELECTED --output json --query "Code.Location" | jq -r
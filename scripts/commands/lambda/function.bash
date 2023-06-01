FUNCTION_LISTING=$(awscli lambda list-functions --output text --query "sort_by(Functions,&FunctionName)[$(auto_filter_joined FunctionName -- "$@")].[FunctionName]")
select_one Function "$FUNCTION_LISTING"

awscli lambda get-function --function-name "$SELECTED" --output json | print_table_excluding .Code GetFunction
ACCOUNT_ID=$(awscli sts get-caller-identity --output text --query "Account")

BUDGETS=$(awscli budgets describe-budgets --account-id $ACCOUNT_ID --output text --query "Budgets[$(auto_filter BudgetName -- $@)].[BudgetName]")

select_one Budget "$BUDGETS"

awscli budgets describe-budget --budget-name $SELECTED --account-id $ACCOUNT_ID --output table
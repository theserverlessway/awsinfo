ACCOUNT_ID=$(awscli sts get-caller-identity --output text --query "Account")

awscli budgets describe-budgets --account-id $ACCOUNT_ID --output table --query "Budgets[$(auto_filter BudgetName -- $@)].{
  \"1.Name\":BudgetName,
  \"2.Limit\":join(' ', [BudgetLimit.Amount, BudgetLimit.Unit]),
  \"3.TimeUnit\":TimeUnit,
  \"4.ActualSpend\":join(' ', [CalculatedSpend.ActualSpend.Amount, CalculatedSpend.ActualSpend.Unit]),
  \"5.ForecastedSpend\":join(' ', [CalculatedSpend.ForecastedSpend.Amount, CalculatedSpend.ForecastedSpend.Unit]),
  \"5.Type\":BudgetType}"
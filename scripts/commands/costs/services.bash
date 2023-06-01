START_DATE=$(awsinfo_date +%Y-%m-01)
END_DATE=$(awsinfo_date --date="$START_DATE +1 month" +%Y-%m-%d)

FILTER=$(auto_filter_joined "join('',Keys)" -- $@)

awscli ce get-cost-and-usage --time-period Start=$START_DATE,End=$END_DATE --granularity MONTHLY --metrics UNBLENDED_COST --group-by Type=DIMENSION,Key=SERVICE --query "ResultsByTime[].reverse(sort_by(Groups,&to_number(Metrics.UnblendedCost.Amount)))[$FILTER].{\"1.Service\": join('',Keys),\"2.Costs\":join(' ',[Metrics.UnblendedCost.Amount,Metrics.UnblendedCost.Unit])}" --output table
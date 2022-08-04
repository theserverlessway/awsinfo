START_DATE=$(awsinfo_date +%Y-%m-01)
END_DATE=$(awsinfo_date +%Y-%m-%d)

FILTER=$(auto_filter "join('',Keys)" -- $@)

SERVICES=$(awscli ce get-cost-and-usage --time-period Start=$START_DATE,End=$END_DATE --granularity MONTHLY --metrics UNBLENDED_COST --group-by Type=DIMENSION,Key=SERVICE --output text --query "ResultsByTime[].Groups[$FILTER].[join('',Keys)]")

select_one Service "$SERVICES"

awscli ce get-cost-and-usage --time-period Start=$START_DATE,End=$END_DATE --granularity MONTHLY --filter "{\"Dimensions\":{\"Key\": \"SERVICE\", \"Values\":[\"$SELECTED\"]}}" --group-by Type=DIMENSION,Key=USAGE_TYPE --metrics UNBLENDED_COST  --query "ResultsByTime[0].reverse(sort_by(Groups,&to_number(Metrics.UnblendedCost.Amount)))[].{\"1.Service\": join('',Keys),\"2.Costs\":join(' ',[Metrics.UnblendedCost.Amount,Metrics.UnblendedCost.Unit])}" --output table

START_DATE=$(awsinfo_date --date="-14 days" +%Y-%m-%d)
END_DATE=$(awsinfo_date +%Y-%m-%d)

FILTER=$(auto_filter "join('',Keys)" -- $@)

SERVICES=$(awscli ce get-cost-and-usage --time-period Start=$START_DATE,End=$END_DATE --granularity MONTHLY --metrics UNBLENDED_COST --group-by Type=DIMENSION,Key=SERVICE --output text --query "ResultsByTime[].Groups[$FILTER].[join('',Keys)]")

select_one Service "$SERVICES"

awscli ce get-cost-and-usage --time-period Start=$START_DATE,End=$END_DATE --granularity DAILY --filter "{\"Dimensions\":{\"Key\": \"SERVICE\", \"Values\":[\"$SELECTED\"]}}" --metrics UNBLENDED_COST  --query "ResultsByTime[].{\"1.Day\":TimePeriod.Start\"2.Costs\":join(' ',[Total.UnblendedCost.Amount,Total.UnblendedCost.Unit])}" --output table

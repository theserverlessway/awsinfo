START_DATE=$(awsinfo_date +%Y-%m-01)
END_DATE=$(awsinfo_date --date="$START_DATE +1 month" +%Y-%m-%d)

FILTER=$(auto_filter_joined "join('',Keys)" -- "$@")

awscli ce get-cost-and-usage --time-period Start=$START_DATE,End=$END_DATE --granularity MONTHLY  --group-by Type=DIMENSION,Key=LINKED_ACCOUNT --metrics UNBLENDED_COST --output table --query "{
    Accounts: DimensionValueAttributes[$(auto_filter_joined Value -- "$@")].{\"1.Id\":Value,\"2.Name\":Attributes.description}, Costs: ResultsByTime[0].Groups[$FILTER].{\"1.Id\":Keys[0],\"2.Name\":Metrics.UnblendedCost.Amount}}
    "
START_DATE=$(date +%Y-%m-01)
END_DATE=$(date --date="$START_DATE +1 month" +%Y-%m-%d)

awscli ce get-cost-and-usage --time-period Start=$START_DATE,End=$END_DATE --granularity MONTHLY --metrics BLENDED_COST UNBLENDED_COST AMORTIZED_COST NET_AMORTIZED_COST NET_UNBLENDED_COST USAGE_QUANTITY NORMALIZED_USAGE_AMOUNT --output table --query "ResultsByTime[0].Total.[
    {\"1.Name\":'AmortizedCost',\"2.Amount\":AmortizedCost.Amount,\"3.Unit\":AmortizedCost.Unit},
    {\"1.Name\":'NetAmortizedCost',\"2.Amount\":NetAmortizedCost.Amount,\"3.Unit\":NetAmortizedCost.Unit},
    {\"1.Name\":'BlendedCost',\"2.Amount\":BlendedCost.Amount,\"3.Unit\":BlendedCost.Unit},
    {\"1.Name\":'UnblendedCost',\"2.Amount\":UnblendedCost.Amount,\"3.Unit\":UnblendedCost.Unit},
    {\"1.Name\":'NetUnblendedCost',\"2.Amount\":NetUnblendedCost.Amount,\"3.Unit\":NetUnblendedCost.Unit},
    {\"1.Name\":'NormalizedUsageAmount',\"2.Amount\":NormalizedUsageAmount.Amount,\"3.Unit\":''},
    {\"1.Name\":'UsageQuantity',\"2.Amount\":UsageQuantity.Amount,\"3.Unit\":''}
    ]
    "
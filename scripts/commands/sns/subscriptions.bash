TOPICS=$(aws sns list-topics --output text --query "Topics[$(filter TopicArn $@)].[TopicArn]")
select_one Stack "$TOPICS"

aws sns list-subscriptions-by-topic --topic-arn $SELECTED --output table --query "Subscriptions"
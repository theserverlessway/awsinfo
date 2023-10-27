TOPICS=$(awscli sns list-topics --output text --query "Topics[$(auto_filter_joined TopicArn -- "$@")].[TopicArn]")
select_one Topic "$TOPICS"

awscli sns list-subscriptions-by-topic --topic-arn "$SELECTED" --output table --query "Subscriptions"
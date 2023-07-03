TOPICS=$(awscli sns list-topics --output text --query "Topics[$(filter TopicArn "$@")].[TopicArn]")
select_one Topic "$TOPICS"

awscli sns list-subscriptions-by-topic --topic-arn "$SELECTED" --output table --query "Subscriptions"
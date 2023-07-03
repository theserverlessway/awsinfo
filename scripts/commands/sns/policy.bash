TOPICS=$(awscli sns list-topics --output text --query "Topics[$(filter TopicArn "$@")].[TopicArn]")
select_one Topic "$TOPICS"

awscli sns get-topic-attributes --topic-arn "$SELECTED" --query Attributes.Policy --output text | jq
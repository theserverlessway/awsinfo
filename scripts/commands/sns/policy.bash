TOPICS=$(awscli sns list-topics --output text --query "Topics[$(auto_filter_joined TopicArn -- "$@")].[TopicArn]")
select_one Topic "$TOPICS"

awscli sns get-topic-attributes --topic-arn "$SELECTED" --query Attributes.Policy --output text | jq
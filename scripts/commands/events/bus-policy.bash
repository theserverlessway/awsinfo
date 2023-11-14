EVENT_BUSES=$(awscli events list-event-buses --output text --query "sort_by(EventBuses,&Name)[$(auto_filter_joined Name Arn -- "$@")].[Name]")
select_one EventBus "$EVENT_BUSES"

awscli events describe-event-bus --name "$SELECTED" --output text --query "Policy || ''"
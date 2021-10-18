source $CURRENT_COMMAND_DIR/pull_requests_shared.sh

select_one PullRequest "$PULL_REQUESTS"

awscli codecommit get-pull-request --output table --query "pullRequest" --pull-request-id $SELECTED
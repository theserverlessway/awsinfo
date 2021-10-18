source $CURRENT_COMMAND_DIR/pull_requests_shared.sh

echo "$PULL_REQUESTS" | xargs -rn 1 bash -c "awscli codecommit get-pull-request --output json --query \"pullRequest.{\\\"1.Id\\\": pullRequestId, \\\"2.Title\\\": title, \\\"3.Author\\\": authorArn}\" --pull-request-id \$0 \$@" | print_table GetPullRequests
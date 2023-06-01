split_args "$@"

POLICIES=$(awscli iam list-policies --output text --query "Policies[$(auto_filter_joined PolicyName PolicyId Path -- $FIRST_RESOURCE)].[Arn]")
select_one Policy "$POLICIES"

POLICY=$SELECTED

VERSIONS=$(awscli iam list-policy-versions --policy-arn $POLICY  --output text --query "Versions[$(auto_filter_joined VersionId -- $SECOND_RESOURCE)].[VersionId]")
select_one Version "$VERSIONS"

awscli iam get-policy-version --policy-arn $POLICY --version-id $SELECTED --output json \
  --query "PolicyVersion"

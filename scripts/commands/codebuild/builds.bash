PROJECTS=$(awscli codebuild list-projects --output text --query "projects[$(auto_filter_joined @ -- "$@")].[@]")

# Once we've listed all the Stacks we need to select one to use. In case there is only one in our list of filtered
# Stacks it will simply select that one. In case there are multiple it will print all and select the first.
select_one Project "$PROJECTS"

BUILD_IDS=$(awscli codebuild list-builds-for-project --max-items 99 --project-name "$SELECTED" --output text --query "ids[].[@]" | head -n 99 )

# Now we can call the `describe-change-set` command with the Stack and ChangeSet we selected above.
# The output is set to table and we're using the Query option to select the values we want to have.
awscli codebuild batch-get-builds --output table --query "builds[].{
  \"1.Id\":id,
  \"2.Number\":buildNumber,
  \"3.Phase\":currentPhase,
  \"4.Status\":buildStatus,
  \"5.StartedAt\":startTime,
  \"6.FinishedAt\":endTime}" --ids $BUILD_IDS
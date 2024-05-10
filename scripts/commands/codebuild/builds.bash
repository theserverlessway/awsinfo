MAX_BUILDS="10"

while getopts "m:" opt; do
  case "$opt" in
  m) MAX_BUILDS="$OPTARG" ;;
  esac
done

shift "$(($OPTIND - 1))"

split_args "$@"

PROJECTS=$(awscli codebuild list-projects --output text --query "projects[$(auto_filter_joined @ -- "$FIRST_RESOURCE")].[@]")

select_one Project "$PROJECTS"

BUILD_IDS=$(awscli codebuild list-builds-for-project --max-items "$MAX_BUILDS" --project-name "$SELECTED" --output text --query "ids[].[@]" | sed 's/^None$//g')

awscli codebuild batch-get-builds --output table --query "reverse(builds)[$(auto_filter_joined id buildNumber currentPhase buildStatus -- "$SECOND_RESOURCE")].{
  \"1.Id\":id,
  \"2.Number\":buildNumber,
  \"3.Phase\":currentPhase,
  \"4.Status\":buildStatus,
  \"5.StartedAt\":startTime,
  \"6.FinishedAt\":endTime}" --ids $BUILD_IDS

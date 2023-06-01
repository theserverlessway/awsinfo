DURATION="180"

while getopts "h:" opt; do
    case "$opt" in
        h) DURATION="$(expr $OPTARG \* 60)" ;;
    esac
done
shift $(($OPTIND-1))

awscli rds describe-events --output table --duration $DURATION --query "reverse(sort_by(Events,&Date))[$(auto_filter_joined SourceArn SourceType Message -- "$@")].{
  \"1.Source\":SourceIdentifier,
  \"2.Type\":SourceType,
  \"3.Message\":Message,
  \"4.Categories\":join(',',EventCategories),
  \"5.Date\":Date}"
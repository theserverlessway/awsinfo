FILTER=""
while getopts "f:" opt; do
  case "$opt" in
  f) FILTER="--parameter-filters Key=Name,Option=Contains,Values=$OPTARG" ;;
  esac
done
shift $(($OPTIND - 1))

awscli ssm describe-parameters $FILTER --output table --query "sort_by(Parameters,&Name)[$(auto_filter_joined Name LastModifiedUser Type -- "$@")].{
  \"1.Name\":Name,
  \"2.Type\":Type,
  \"3.Version\":Version,
  \"4.LastModifiedUser\":LastModifiedUser}"

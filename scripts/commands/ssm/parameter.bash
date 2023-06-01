FILTER=""
while getopts "f:" opt; do
  case "$opt" in
  f) FILTER="--parameter-filters Key=Name,Option=Contains,Values=$OPTARG" ;;
  esac
done
shift $(($OPTIND - 1))

PARAMETER_LISTING=$(awscli ssm describe-parameters  "$FILTER" --output text --query "sort_by(Parameters,&Name)[$(auto_filter_joined Name LastModifiedUser Type -- "$@")].[Name]")
select_one Parameter "$PARAMETER_LISTING"

awscli ssm get-parameter --name "$SELECTED" --with-decryption --output table --query "Parameter.{
  \"1.Name\":Name,
  \"2.Type\":Type,
  \"3.Value\":Value,
  \"3.Version\":Version}"

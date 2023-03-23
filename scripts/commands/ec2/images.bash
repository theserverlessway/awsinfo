OWNER="--owners $(awscli sts get-caller-identity --query Account --output text)"

while getopts "o:" opt; do
  case "$opt" in
  o) OWNER="--owners $OPTARG" ;;
  esac
done
shift $(($OPTIND - 1))

awscli ec2 describe-images $OWNER --filter "Name=name,Values=*$@*" --output table --query "Images[].{
  \"1.Name\":Name,
  \"2.ImageId\":ImageId,
  \"3.PlatformDetails\":PlatformDetails,
  \"4.Architecture\":Architecture,
  \"5.State\":State}"

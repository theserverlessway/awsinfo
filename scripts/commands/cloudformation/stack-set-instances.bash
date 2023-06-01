while getopts "a:r:" opt; do
    case "$opt" in
        a) STACK_SET_ACCOUNT="--stack-instance-account $OPTARG" ;;
        r) STACK_SET_REGION="--stack-instance-region $OPTARG" ;;
    esac
done
shift $(($OPTIND-1))

split_args "$@"

STACKSET_LISTING=$(awscli cloudformation list-stack-sets --status ACTIVE --output text --query "sort_by(Summaries,&StackSetName)[$(auto_filter_joined StackSetName -- "$FIRST_RESOURCE")].[StackSetName]")
select_one StackSet "$STACKSET_LISTING"

awscli cloudformation list-stack-instances --stack-set-name $SELECTED ${STACK_SET_ACCOUNT:-} ${STACK_SET_REGION:-} --output json --query "sort_by(Summaries,&join('',[@.Account,@.Region]))[$(auto_filter_joined Account Region StackId Status StatusReason -- "$SECOND_RESOURCE")].{
  \"1.Account\":Account,
  \"2.Region\":Region,
  \"3.StackName\":StackId,
  \"4.Status\":Status,
  \"4.StatusReason\":StatusReason}" |   sed "s/arn.*stack\/\(.*\)\/.*\"/\1\"/g" | print_table ListStackInstances


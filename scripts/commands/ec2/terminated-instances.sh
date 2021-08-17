EC2_FILTER="--filter Name=instance-state-name,Values=pending,running"
SORT_BY="Reservations,&Instances[0].LaunchTime"


while getopts "tn" opt; do
    case "$opt" in
        t) EC2_FILTER="";;
        n) SORT_BY="Reservations,&Instances[0].Tags[?Key=='Name'].Value|[0]||''";;
    esac
done
shift $(($OPTIND-1))
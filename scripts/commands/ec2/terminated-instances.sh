EC2_FILTER="--filter Name=instance-state-name,Values=pending,running"

while getopts "t" opt; do
    case "$opt" in
        t) EC2_FILTER="";;
    esac
done
shift $(($OPTIND-1))
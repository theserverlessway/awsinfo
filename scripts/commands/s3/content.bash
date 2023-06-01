while getopts "p:" opt; do
    case "$opt" in
        p) PREFIX="--prefix $OPTARG" ;;
    esac
done
shift $(($OPTIND-1))

split_args "$@"

BUCKETS=$(awscli s3api list-buckets --output text --query "Buckets[$(auto_filter_joined Name -- "$FIRST_RESOURCE")].[Name]")

select_one Bucket "$BUCKETS"

BUCKET=$SELECTED

KEYS=$(awscli s3api list-objects-v2 --bucket $BUCKET ${PREFIX:-} --output text --query "sort_by(Contents,&Key)[$(auto_filter_joined Key  -- "$SECOND_RESOURCE")].[Key]")

select_one Key "$KEYS"

awscli s3 cp s3://$BUCKET/$SELECTED -
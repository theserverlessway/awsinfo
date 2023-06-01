SORT_BY="sort_by(Contents,&Key)"

while getopts "p:m:l" opt; do
    case "$opt" in
        p) PREFIX="--prefix $OPTARG" ;;
        m) MAX_ITEMS="--max-items $OPTARG" ;;
        l) SORT_BY="reverse(sort_by(Contents,&LastModified))" ;;
    esac
done
shift $(($OPTIND-1))

split_args "$@"

BUCKETS=$(awscli s3api list-buckets --output text --query "Buckets[$(auto_filter_joined Name -- "$FIRST_RESOURCE")].[Name]")

select_one Bucket "$BUCKETS"

awscli s3api list-objects-v2 --bucket $SELECTED ${PREFIX:-} ${MAX_ITEMS:-} --output table --query "$SORT_BY[$(auto_filter_joined Key  -- "$SECOND_RESOURCE")].{
  \"1.Key\":Key,
  \"2.LastModified\":LastModified,
  \"3.ETag\":ETag,
  \"4.Storage\":StorageClass
  \"5.Size\":Size}"

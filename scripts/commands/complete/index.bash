DIR="$(dirname "$(awsinfo_readlink -f "$0")")"

python $DIR/complete.py $DIR

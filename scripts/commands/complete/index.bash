DIR="$(dirname "$(readlink -f "$0")")"

python $DIR/complete.py $DIR

DIR="$(dirname "$(awsinfo_readlink -f "$0")")"

python3 $DIR/complete_zsh.py $DIR

function awsinfo_date() {
  if command -v gdate > /dev/null; then
    gdate "$@"
  else
    date "$@"
  fi
}
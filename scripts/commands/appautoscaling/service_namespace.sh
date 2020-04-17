if [[ "$FIRST_RESOURCE" = "" || ! "$FIRST_RESOURCE" =~ ^[[:space:]][a-z1-9-]+$ ]]
then
  echo "Plaese provide a single service namespace without whitespace as first argument"
  exit 1
fi
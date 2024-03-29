echoerr() {
    echo -e "$*" 1>&2;
}

export -f echoerr

echoinfomsg() {
    echoerr "$BLUE""$*""$NC"
}

export -f echoinfomsg

echoerrmsg() {
    echoerr "$RED""$*""$NC"
}

export -f echoerrmsg

echosuccess() {
    echo -e "$GREEN""$*""$NC" 1>&2;
}

export -f echosuccess

function select_one(){
  select_one_unsorted "$1" "$(sort <<< "$2")"
}

function select_one_unsorted(){
    type="$1"
    OUTPUT="$2"
    if [[ -z "$OUTPUT" ]]
    then
        echoerrmsg "Found no matching $type with supplied arguments"
        exit 0
    else
        COUNT=$(grep -c '[^[:space:]]' <<< "$OUTPUT")
        if [[ $COUNT -gt 1 ]]
        then
            echoerrmsg "Found multiple matches for $type. Selecting First"
            echoerr "$OUTPUT"
        fi
    fi
    ONE=$(head -n 1 <<< "$OUTPUT")
    echosuccess "Selected $type $ONE"
    eval "SELECTED='$ONE'"
}

function split_args(){
  FIRST_ARGS=('')
  while test ${#} -gt 0
  do
    if [[ "$1" == '--' ]]
    then
      shift
      break
    else
      FIRST_ARGS+=("$1")
      shift
    fi
  done
  eval 'FIRST_RESOURCE="${FIRST_ARGS[@]}"'
  eval 'SECOND_RESOURCE="$@"'
}

function print_table(){
  jq -crs | python3 "$DIR/combine_calls.py" "$1"
}

function print_table_excluding(){
  jq -Mcr "del($1)" | print_table "$*"
}

function time_parsing() {
    timestamp=$(awsinfo_date --date "$1" +%s)
    if [[ "$?" -ne 0 ]]; then
        exit 1;
    fi
    echo $((timestamp * 1000))
}

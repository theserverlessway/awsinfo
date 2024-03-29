function join_with_to_string {
    joiner=$1
    shift
    OUTPUT=""
    if [[ $# -gt 0 ]]
    then
        OUTPUT="$1"
        shift
        for var in $@
        do
            OUTPUT+=$joiner
            OUTPUT+="to_string($var)"
        done
    fi
    echo $OUTPUT
}

function join {
    joiner=$1
    shift
    OUTPUT=""
    if [[ $# -gt 0 ]]
    then
        OUTPUT="$1"
        shift
        for var in $@
        do
            OUTPUT+=$joiner
            OUTPUT+="$var"
        done
    fi
    echo $OUTPUT
}

function filter_query(){
    item=$1
    shift
    if [[ $# -gt 0 ]]
    then
        declare -A FILTERS
        while [[ $# -gt 0 ]]
        do
            FILTERS[$#]="contains(to_string($item),'$1')"
            shift
        done
        echo "$(join '&&' "${FILTERS[@]}")"
    else
        echo "true==true"
    fi
}

function auto_filter_joined(){
  if [[ $# -gt 1 ]]
  then
    split_args "$@"
    if [ -n "$FIRST_RESOURCE" ] && [ -n "$SECOND_RESOURCE" ]
    then
      FILTER_STRING="join('',[$(join_with_to_string "||''," \'\' $FIRST_RESOURCE)||''])"
      echo ?"$(filter_query "$FILTER_STRING" $SECOND_RESOURCE)"
    fi
  fi
}
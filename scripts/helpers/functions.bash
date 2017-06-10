function join {
    joiner=$1
    shift
    OUTPUT="$1"
    shift
    if [[ $# -gt 0 ]]
    then
        for var in $@
        do
            OUTPUT+=$joiner
            OUTPUT+=$var
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
            FILTERS[$#]="contains($item,'$1')"
            shift
        done
        echo "$(join '&&' ${FILTERS[@]})"
    else
        echo ""
    fi
}

function filter(){
    if [[ $# -gt 1 ]]
    then
        echo -n "?"
        filter_query "$@"
    fi
}

echoerr() {
    echo -e "$@" 1>&2;
}

echoerrmsg() {
    echoerr "$RED""$@""$NC"
}

function select_one(){
    type=$1
    OUTPUT="$2"
    if [[ $(echo "$OUTPUT" | grep -c '[^[:space:]]') != 1 ]]
    then
        echoerrmsg "Make sure your arguments match exactly one $type:"
        echoerr "$OUTPUT"
        exit 1
    else
        echo "$OUTPUT"
    fi
}
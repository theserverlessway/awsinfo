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

echosuccess() {
    echo -e "$GREEN""$@""$NC"
}

function select_one(){
    type=$1
    OUTPUT=$(sort <<< "$2")
    if [[ -z "$OUTPUT" ]]
    then
        echoerrmsg "Found no matching $type with supplied arguments"
        exit 1
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
    eval SELECTED=$ONE
}
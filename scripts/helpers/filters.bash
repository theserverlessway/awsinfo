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
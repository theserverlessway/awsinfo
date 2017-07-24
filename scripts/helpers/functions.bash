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
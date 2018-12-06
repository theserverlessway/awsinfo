function awscli() {
    if [[ ! -z "$VERBOSE" ]]
    then
      command=$(echo aws $@ ${AWS_OPTIONS} | sed 's/\([,{:]\) /\1/g ; s/"/\\"/g ;  s/--query \([^ ]*\)/--query \"\1\"/g ')
      echoinfomsg $command
    fi
    aws "$@" ${AWS_OPTIONS}
}

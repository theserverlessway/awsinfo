#!/bin/bash

set -euo pipefail

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export SECOND=1000
export MINUTE=$((SECOND * 60))
export HOUR=$((MINUTE * 60))
export DAY=$((HOUR * 24))
export WEEK=$((DAY * 7))

AWS_OPTIONS=""

function awscli() {
    aws $@ ${AWS_OPTIONS}
}

# Parse common AWSCLI arguments so subcommands don't have to deal with them
args=("$@")
i="0"

while [[ $i -lt $# ]]
do
	current=${args[$i]}
	case "$current" in
		--profile)
			if [[ $(($i+1)) -eq $(($#)) ]]
			then
				echo Please provide a profile with the --profile option
				exit 1
			else
				AWS_OPTIONS=" --profile ${args[$i+1]} "
				unset args[$i]
				unset args[$(($i+1))]
				i=$(($i+1))
			fi
		;;
		*)
		;;
	esac
	i=$(($i+1))
done

set -- ${args[*]}

if [[ "$#" -gt 0 ]]
then
    command=$1
    shift
else
    echo "Please provide the command to run"
    exit 1
fi

if [[ -d "$DIR/$command" ]]
then
    if [[ "$#" -gt 0 && -f "$DIR/$command/$1.bash" ]]
    then
        subcommand=$1
        shift
        source $DIR/$command/$subcommand.bash
    else
        index_file=$DIR/$command/index.bash
        if [[ -f "$index_file" ]];
        then
            source $index_file
        else
            echo "Command not available: $command"
            exit 1
        fi
    fi
else
    echo "Command not available: $command"
    exit 1
fi
#!/bin/bash

set -euo pipefail

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export SECOND=1000
export MINUTE=$((SECOND * 60))
export HOUR=$((MINUTE * 60))
export DAY=$((HOUR * 24))
export WEEK=$((DAY * 7))

if [[ "$#" -gt 0 ]]
then
    command=$1
    shift
else
    echo -e "Please choose one of the available commands:\n"
    command=commands
fi

# Include Files from other helpers
source $DIR/helpers/awscli.bash

source $DIR/helpers/arguments.bash

COMMANDS_DIR=$DIR/commands
CURRENT_COMMAND_DIR=$COMMANDS_DIR/$command
if [[ -d "$CURRENT_COMMAND_DIR" ]]
then
    if [[ "$#" -gt 0 && -f "$CURRENT_COMMAND_DIR/$1.bash" ]]
    then
        subcommand=$1
        shift
    else
        if [[ -f "$CURRENT_COMMAND_DIR/index.bash" ]];
        then
            subcommand=index
        else
            echo "Command not available: $command"
            exit 1
        fi
    fi
else
    echo "Command not available: $command"
    exit 1
fi

if [[ -z "$HELP" ]]
then
    source $CURRENT_COMMAND_DIR/$subcommand.bash
else
    cat $DIR/header.txt
    echo -e "\n"
    cat $CURRENT_COMMAND_DIR/$subcommand.md
    echo -e "\n"
fi
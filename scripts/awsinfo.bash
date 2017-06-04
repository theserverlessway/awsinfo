#!/bin/bash

set -euo pipefail

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export SECOND=1000
export MINUTE=$((SECOND * 60))
export HOUR=$((MINUTE * 60))
export DAY=$((HOUR * 24))
export WEEK=$((DAY * 7))

# Include Files from other helpers
source $DIR/helpers/awscli.bash

if [[ "$#" -gt 0 ]]
then
    command=$1
    shift
else
    echo "Please provide the command to run"
    exit 1
fi

COMMANDS_DIR=$DIR/commands
CURRENT_COMMAND_DIR=$COMMANDS_DIR/$command
if [[ -d "$CURRENT_COMMAND_DIR" ]]
then
    if [[ "$#" -gt 0 && -f "$CURRENT_COMMAND_DIR/$1.bash" ]]
    then
        subcommand=$1
        shift
        source $CURRENT_COMMAND_DIR/$subcommand.bash
    else
        index_file=$CURRENT_COMMAND_DIR/index.bash
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
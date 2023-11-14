source $CURRENT_COMMAND_DIR/build_selection.sh

awscli codebuild batch-get-builds --output table --query builds --ids $SELECTED
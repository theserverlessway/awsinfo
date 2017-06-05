awsinfo() {
    docker run -it -v ~/.aws:/root/.aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_DEFAULT_PROFILE -e AWS_CONFIG_FILE flomotlik/awsinfo:latest $@
}

stack_name(){
    basename $BATS_TEST_FILENAME | tr '.' '-'
}
deploy_stack() {
    export FORMICA_STACK=$(stack_name)
    echo "Creating Stack $FORMICA_STACK"
    cd $BATS_TEST_DIRNAME && formica new && formica deploy
}

remove_stack() {
    export FORMICA_STACK=$(stack_name)
    echo "Removing Stack $FORMICA_STACK"
    cd $BATS_TEST_DIRNAME && formica remove
}
awsinfo() {
    run command -v docker
    if [[ $status == 0 ]];
    then
        docker run -it -v ~/.aws:/root/.aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_DEFAULT_PROFILE -e AWS_CONFIG_FILE flomotlik/awsinfo:dev "$@"
    else
        ./scripts/awsinfo.bash "$@"
    fi
}

stack_name(){
    basename $BATS_TEST_FILENAME-$STACKPOSTFIX | tr '.' '-'
}
deploy_stack() {
    FORMICA_STACK=$(stack_name)
    echo "Creating Stack $FORMICA_STACK"
    cd $BATS_TEST_DIRNAME && formica new -s $FORMICA_STACK && formica deploy -s $FORMICA_STACK
}

remove_stack() {
    FORMICA_STACK=$(stack_name)
    echo "Removing Stack $FORMICA_STACK"
    cd $BATS_TEST_DIRNAME && formica remove -s $FORMICA_STACK
}

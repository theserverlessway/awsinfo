load ../awsinfo
load ../test-helpers/bats-assert/load

@test "fail if no command specified " {
    run awsinfo
    assert_failure
    assert_output -p 'Please provide a command to run'
}
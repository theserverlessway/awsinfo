load ../awsinfo
load ../test-helpers/bats-assert/load

@test "print commands if no command specified" {
    run awsinfo
    assert_success
    assert_output -p 'Please choose one of the available commands'
    assert_output -p 'logs groups'
    assert_output -p 'logs'
    assert_output -p 'commands'
}

@test "print all available commands" {
    run awsinfo commands
    assert_success
    assert_output -p 'Available Commands'
    assert_output -p 'logs groups'
    assert_output -p 'logs'
    assert_output -p 'commands'
}

@test "print help page" {
    run awsinfo commands --help
    assert_success
    assert_output -p 'Lists all available commands'
}

@test "no usage of aws cli directly in commands" {
    run grep -r "aws " scripts/commands
    assert_failure
}

@test "docs available for every command" {
    find scripts/commands -name "*.bash" | awk '{sub(".bash",".md",$0); print }' | xargs ls
}
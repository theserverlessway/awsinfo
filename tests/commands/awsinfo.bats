load ../awsinfo
load ../test-helpers/bats-assert/load

@test "print serviecs if no service specified" {
    run awsinfo
    assert_success
    assert_output -p 'Please choose one of the available commands'
    assert_output -p '  cfn'
    assert_output -p '  logs'
    assert_output -p '  commands'
}

@test "print all available services" {
    run awsinfo commands
    assert_success
    assert_output -p 'Supported Services'
    assert_output -p '  cfn'
    assert_output -p '  logs'
    assert_output -p '  commands'
}

@test "print all commands for a service" {
    run awsinfo commands cfn
    assert_success
    assert_line -p 'Available Commands:'
    assert_line -p '  cfn'
    assert_line -p '  cfn change-sets'
    assert_line -p '  cfn events'
}

@test "print help page" {
    run awsinfo commands --help
    assert_success
    assert_output -p 'awsinfo commands [service]'
}

@test "no usage of aws cli directly in commands" {
    run grep -r "aws " scripts/commands
    assert_failure
}

@test "no set, pipefail or shebang in commands" {
    run grep -r "pipefail" scripts/commands
    assert_failure
    run grep -r "^#\!" scripts/commands
    assert_failure
    run grep -r "^set " scripts/commands
    assert_failure
}

@test "docs available for every command" {
    find scripts/commands -name "*.bash" | awk '{sub(".bash",".md",$0); print }' | xargs ls
}
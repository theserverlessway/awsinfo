load ../../awsinfo
load ../../test-helpers/bats-assert/load

setup(){
  deploy_stack
}

@test "List all stacks with and without stack match parameter" {
  run awsinfo cfn
  assert_output -p index-bats
  assert_output -p CREATE_COMPLETE
  assert_success

  run awsinfo cfn index-bats
  assert_output -p index-bats
  assert_output -p CREATE_COMPLETE
  assert_success
}

teardown(){
  remove_stack
}
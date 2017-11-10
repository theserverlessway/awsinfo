load ../../awsinfo
load ../../test-helpers/bats-assert/load

setup(){
  deploy_stack
}

@test "List all stacks and resources with with and without stack match parameter and subresource filtering" {
  run awsinfo cfn
  assert_output -p index-bats
  assert_output -p CREATE_COMPLETE
  assert_success

  run awsinfo cfn index-bats
  assert_output -p index-bats
  assert_output -p CREATE_COMPLETE
  assert_success

  run awsinfo cfn resources index bats
  assert_output -p index-bats
  assert_output -p CREATE_COMPLETE
  assert_output -p FirstLogGroup
  assert_output -p SecondLogGroup
  assert_success

  run awsinfo cfn resources index bats --
  assert_output -p index-bats
  assert_output -p CREATE_COMPLETE
  assert_output -p FirstLogGroup
  assert_output -p SecondLogGroup
  assert_success

  run awsinfo cfn resources index bats -- Second Log Group
  assert_output -p index-bats
  assert_output -p CREATE_COMPLETE
  refute_output -p FirstLogGroup
  assert_output -p SecondLogGroup
  assert_success
}

teardown(){
  remove_stack
}
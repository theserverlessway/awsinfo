load ../../awsinfo
load ../../test-helpers/bats-assert/load

setup(){
  deploy_stack
}

@test "listing all or specific log groups " {
  run awsinfo logs groups
  assert_output -p AWSInfoTestLogGroup
  assert_success

  run awsinfo logs groups InfoTestLogGroup
  assert_output -p AWSInfoTestLogGroup
  assert_success

  run awsinfo logs groups NotMatching
  assert_output ''
  assert_success

  run awsinfo logs groups one two three
  assert_failure
  assert_output -p 'Plase provide one argument to match your log groups with'
}

teardown(){
  remove_stack
}
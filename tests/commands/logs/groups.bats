load ../../awsinfo
load ../../test-helpers/bats-support/load
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
}

teardown(){
  remove_stack
}

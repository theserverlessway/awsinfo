# `awsinfo cfn exports [substrings]*`

List all CloudFormation exports, with their `Name`, and `Value`.
If `substrings` are given it will only print exports that contain all `substrings` either
in the `Name` or `Stack` the export comes from.
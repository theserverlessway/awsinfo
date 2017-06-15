# `awsinfo cfn events [substrings]*`

List the last 50 CloudFormation Events for a specific Stack. It will select the Stack that 
contains all supplied substrings. For long status messages it might break up the table and
make it less readable (the AWSCLI doesn't provide an in-table line break).
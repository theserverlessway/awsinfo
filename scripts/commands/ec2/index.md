# `awsinfo ec2 [substrings]+`

List all EC2 instances with their most important data. 

If `substrings` is given it will only print instances where all `substrings` are part of the Tag `Name` or 
the InstanceId. This makes it easy to limit the instances shown without having to enter the full Name or InstanceId.
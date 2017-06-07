# `awsinfo ec2 [substring]`

List all EC2 instances with their most important data. If `substring` is given it will 
only print instances where `substring` is part of the Tag `Name` or in the InstanceId, 
making it easy to limit the instances shown without having to enter the full Name or InstanceId.
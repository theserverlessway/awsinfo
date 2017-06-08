# `awsinfo ec2 sg [substrings]+`

List all Security Groups. 

If `substrings` is given it will only print security groups where all `substrings` are part of the `Name`,
 `GroupName`, `Id` or `VpcId`. This makes it easy to limit the instances shown without having to enter the 
 full Name or Ids.
 
## Options:
* `-p`: Show In/Out permissions of a Security Group. Best to filter down to a specific group with this option
as the output gets very long.
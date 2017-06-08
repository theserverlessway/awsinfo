# `awsinfo ec2 keys [substrings]+`

List all EC2 key pairs. 

If `substrings` is given it will only print key pairs where all `substrings` are part of the `Key Name` or 
the `Fingerpring`. This makes it easy to limit the instances shown without having to enter the full Name or Fingerprint.
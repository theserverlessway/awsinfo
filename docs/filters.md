---
title: AWSInfo Filters
subtitle: How to filter resources for quick access
weight: 100
---

One of the most powerful features of AWSInfo is the built-in filtering of resources. When
working with the AWSCli you constantly have to copy the exact name of a resource to use in another command. This makes moving between different resources and details you want to see cumbersome.

AWSInfo has built-in filtering for many resources, making it very easy for you to find what you're actually looking for.

To filter elements AWSInfo uses the `--query` option from the AWSClI extensively. Results are therefore mostly not filtered on the AWS Backend, but on the developer machine after the request to AWS.

## Filter a list of elements

In the following example we have a list of CloudFormation Stacks.

```
○ → awsinfo cloudformation
----------------------------------------------------------------------------------------------------
|                                          DescribeStacks                                          |
+---------------------+------------------+----------------------------+----------------------------+
|       1.Name        |    2.Status      |      3.CreationTime        |       4.LastUpdated        |
+---------------------+------------------+----------------------------+----------------------------+
|  basic-account-setup|  CREATE_COMPLETE |  2017-09-22T15:15:33.268Z  |  2017-09-22T15:16:17.886Z  |
|  tslw-infrastructure|  UPDATE_COMPLETE |  2017-09-25T13:03:22.774Z  |  2017-10-08T18:50:57.129Z  |
|  tslw-frontend      |  UPDATE_COMPLETE |  2017-09-25T13:03:22.774Z  |  2017-10-08T18:50:57.129Z  |
+---------------------+------------------+----------------------------+----------------------------+
```

Now what if we only want to see stacks that contain `tslw`. At the same time we're lazy so we don't even want to type all of `tslw` and just type something that is unique.

```
○ → awsinfo cloudformation ts
----------------------------------------------------------------------------------------------------
|                                          DescribeStacks                                          |
+---------------------+------------------+----------------------------+----------------------------+
|       1.Name        |    2.Status      |      3.CreationTime        |       4.LastUpdated        |
+---------------------+------------------+----------------------------+----------------------------+
|  tslw-infrastructure|  UPDATE_COMPLETE |  2017-09-25T13:03:22.774Z  |  2017-10-08T18:50:57.129Z  |
|  tslw-frontend      |  UPDATE_COMPLETE |  2017-09-25T13:03:22.774Z  |  2017-10-08T18:50:57.129Z  |
+---------------------+------------------+----------------------------+----------------------------+
```

AWSInfo checks if the filters you've entered (yes it supports multiple filter terms) are in the Name field. Only Stacks that have all terms in the Name will be shown. So if we want to limit to infrastructure stacks only we could simply do the following:

```
○ → awsinfo cloudformation ts in
----------------------------------------------------------------------------------------------------
|                                          DescribeStacks                                          |
+---------------------+------------------+----------------------------+----------------------------+
|       1.Name        |    2.Status      |      3.CreationTime        |       4.LastUpdated        |
+---------------------+------------------+----------------------------+----------------------------+
|  tslw-infrastructure|  UPDATE_COMPLETE |  2017-09-25T13:03:22.774Z  |  2017-10-08T18:50:57.129Z  |
+---------------------+------------------+----------------------------+----------------------------+
```

The filtering mechanism makes it very easy and fast to get the exact resource you want to see out of a list.

## Select a Resource for which to show Subresources

Often you want to select one resource and show its subresources. An example would be a listing all the resources created for a CloudFormation stack. You simply provide filters in the same way as above and AWSInfo will at first get a list of the CloudFormation stacks, filter them with your parameters to get one stack (or select the first if multiple are found) and then select all the created resources for that stack.

```
○ → awsinfo cloudformation resources tsl
Selected Stack tslw-infrastructure
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|                                                                                                      ListStackResources                                                                                                       |
+-----------------------------------------------+---------------------------------------------------------------------------------------+---------------------------------------+------------------+----------------------------+
|                  1.LogicalId                  |                                     2.PhysicalId                                      |                3.Type                 |    4.Status      |       5.LastUpdated        |
+-----------------------------------------------+---------------------------------------------------------------------------------------+---------------------------------------+------------------+----------------------------+
|  DevelopmentTheserverlesswayComWebBucket      |  tslw-infrastructure-developmenttheserverlesswayco-upuwlm1zjw2                        |  AWS::S3::Bucket                      |  CREATE_COMPLETE |  2017-10-08T18:33:49.211Z  |
|  DevelopmentTheserverlesswayComWebBucketPolicy|  tslw-infrastructure-DevelopmentTheserverlesswayC-1T7Y2DIXGR0Q2                       |  AWS::S3::BucketPolicy                |  CREATE_COMPLETE |  2017-10-08T18:51:01.814Z  |
|  TheserverlesswayComBucketDistribution        |  E38MQE4HHAZURU                                                                       |  AWS::CloudFront::Distribution        |  UPDATE_COMPLETE |  2017-09-27T14:54:26.866Z  |
|  TheserverlesswayComCertificate               |  arn:aws:acm:us-east-1:343826926861:certificate/5638626f-742c-47a7-9360-70df8a4d19cb  |  AWS::CertificateManager::Certificate |  CREATE_COMPLETE |  2017-09-26T14:10:15.306Z  |
|  TheserverlesswayComDistributionRecord        |  theserverlessway.com                                                                 |  AWS::Route53::RecordSet              |  CREATE_COMPLETE |  2017-09-27T10:51:13.920Z  |
|  TheserverlesswayComHostedZone                |  Z3RGV4GYUT2GEW                                                                       |  AWS::Route53::HostedZone             |  CREATE_COMPLETE |  2017-09-25T13:04:53.415Z  |
|  TheserverlesswayComMXRecord                  |  theserverlessway.com                                                                 |  AWS::Route53::RecordSet              |  CREATE_COMPLETE |  2017-09-25T13:05:58.200Z  |
|  TheserverlesswayComRedirectBucketDistribution|  E50AVSERL64BC                                                                        |  AWS::CloudFront::Distribution        |  UPDATE_COMPLETE |  2017-09-27T14:54:29.587Z  |
|  TheserverlesswayComRedirectWebBucket         |  tslw-infrastructure-theserverlesswaycomredirectwe-1ie35l0gtega8                      |  AWS::S3::Bucket                      |  CREATE_COMPLETE |  2017-09-26T15:31:46.561Z  |
|  TheserverlesswayComTXTRecord                 |  theserverlessway.com                                                                 |  AWS::Route53::RecordSet              |  UPDATE_COMPLETE |  2017-09-26T13:29:09.276Z  |
|  TheserverlesswayComWebBucket                 |  tslw-infrastructure-theserverlesswaycomwebbucket-1cgcxavw8mthj                       |  AWS::S3::Bucket                      |  CREATE_COMPLETE |  2017-09-26T14:08:33.508Z  |
|  TheserverlesswayComWebBucketPolicy           |  tslw-infrastructure-TheserverlesswayComWebBucket-1P9LQZKX9T2SR                       |  AWS::S3::BucketPolicy                |  CREATE_COMPLETE |  2017-09-26T15:10:51.721Z  |
|  WwwTheserverlesswayComDistributionRecord     |  www.theserverlessway.com                                                             |  AWS::Route53::RecordSet              |  CREATE_COMPLETE |  2017-09-27T10:48:38.026Z  |
+-----------------------------------------------+---------------------------------------------------------------------------------------+---------------------------------------+------------------+----------------------------+

```

Super easy and something you'll use constantly.

## Filtering subresources

If you have a large enough CloudFormation stack (and of course the same applies to any other service AWSInfo supports) the full list of resources might be a bit much to read. Wouldn't it be nice to be able to filter down sub-resources as well?

Many different commands allow you to split filters for the first and second resource with `--`. In the following Example we want to see all stack resources that are a RecordSet

For CloudFormation stack resources AWSInfo matches against the LogicalId, PhysicalId and the Type. And because the match just has to be unique we don't even have to write out `RecordSet` but can simply write `Rec Set` or any other unique combination. Filtering also happens across all supported attributes, so we can add multiple filter terms that can match on mutliple attributes, e.g. if we want to find all Record Sets that also have www in them we can use the following filter command. This makes filtering out similar resources easier as well as some attribute might share a very similar name, but resources can be differentiated by the combination of multiple attributes.

```
○ → awsinfo-dev cloudformation resources tsl -- Rec Set www
Selected Stack tslw-infrastructure
----------------------------------------------------------------------------------------------------------------------------------------------------
|                                                                ListStackResources                                                                |
+-------------------------------------------+---------------------------+--------------------------+------------------+----------------------------+
|                1.LogicalId                |       2.PhysicalId        |         3.Type           |    4.Status      |       5.LastUpdated        |
+-------------------------------------------+---------------------------+--------------------------+------------------+----------------------------+
|  WwwTheserverlesswayComDistributionRecord |  www.theserverlessway.com |  AWS::Route53::RecordSet |  CREATE_COMPLETE |  2017-09-27T10:48:38.026Z  |
+-------------------------------------------+---------------------------+--------------------------+------------------+----------------------------+
```

Check the documentation of each command if it supports subresource filtering. If it doesn't yet please open an issue or PR or let me know [on Twitter](https://twitter.com/flomotlik).
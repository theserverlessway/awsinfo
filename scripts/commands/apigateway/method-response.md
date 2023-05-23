# `awsinfo apigateway method-response [first-filters]+ -- [second-filters]*`

Describe a Method Response for a Resource in a Rest API defined by the HTTP Method and Status

## Options

* `-m`: HTTP Method. Default GET
* `-s`: HTTP Status. Default 200

## First Filter matches against

* Id
* Name
* EndpointConfigurationType

## Second Filter matches against

* Path
* Id
* ParentId
* ResourceMethods
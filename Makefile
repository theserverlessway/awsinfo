.PHONY: build

CONTAINER_NAME=flomotlik/awsinfo
CONTAINER=$(CONTAINER_NAME):dev
TEST_HELPERS=tests/test-helpers
TESTFILES=tests/commands/**/*.bats tests/commands/*.bats

build:
	docker build -t $(CONTAINER) .

build-no-cache:
	docker build --no-cache -t $(CONTAINER) .

release: build
	docker tag $(CONTAINER) $(CONTAINER_NAME):latest
	docker push $(CONTAINER_NAME):latest

test: build-no-cache
	STACKPOSTFIX=$(shell date +%s%N) ./tests/test-helpers/bats/bin/bats $(TESTFILES)

dev: build
	docker run --entrypoint bash -it -v ~/.aws:/root/.aws -v `pwd`:/app -w /app -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_PROFILE -e AWS_CONFIG_FILE $(CONTAINER)

prepare:
	rm -fr $(TEST_HELPERS)
	mkdir -p $(TEST_HELPERS)
	git clone https://github.com/sstephenson/bats $(TEST_HELPERS)/bats
	git clone https://github.com/ztombol/bats-assert.git $(TEST_HELPERS)/bats-assert
	pip install formica-cli -U
	pip install awscli -U
	pip install awsie -U

command-docs:
	@find scripts/commands -name "*.bash" | awk '{sub(/\.bash/, "", $$0); n=split($$0,file,"/"); sub(/index/, "", file[n]); print "* [`" file[n-1] " " file[n] "`](https://github.com/flomotlik/awsinfo/blob/master/" $$0 ".md)" }' | sort

LOG_TIMESTAMP=$(shell echo $$(($$(date +%s) * 1000)))
LOG_STREAM_NAME=test-log-stream-$(LOG_TIMESTAMP)

put-log-message:
	aws logs create-log-stream --log-group-name test-log-group --log-stream-name $(LOG_STREAM_NAME)
	aws logs put-log-events --log-group-name test-log-group --log-stream-name  $(LOG_STREAM_NAME) --log-events timestamp=$(LOG_TIMESTAMP),message=TestMessage-$(LOG_TIMESTAMP)

FORMICA_STACK=awsinfo-integration-user
create-integration-user:
	cd tests && formica new --stack $(FORMICA_STACK) --capabilities CAPABILITY_IAM
	formica deploy --stack $(FORMICA_STACK)

update-integration-user:
	cd tests && formica change --stack $(FORMICA_STACK) --capabilities CAPABILITY_IAM
	formica deploy --stack $(FORMICA_STACK)

.PHONY: build

CONTAINER=flomotlik/awsinfo
TEST_HELPERS=tests/test-helpers
TESTFILES=tests/commands/**/*.bats tests/commands/*.bats

build:
	docker build -t $(CONTAINER):master .

build-no-cache:
	docker build --no-cache -t $(CONTAINER):master .

release: build
	docker tag $(CONTAINER):master $(CONTAINER):latest
	docker push $(CONTAINER):latest

test: build
	./tests/test-helpers/bats/bin/bats $(TESTFILES)

bash: build
	docker run --entrypoint bash -it -v ~/.aws:/root/.aws -v `pwd`:/app -w /app -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_DEFAULT_PROFILE -e AWS_CONFIG_FILE $(CONTAINER):master

prepare:
	rm -fr $(TEST_HELPERS)
	mkdir -p $(TEST_HELPERS)
	git clone https://github.com/sstephenson/bats $(TEST_HELPERS)/bats
	git clone https://github.com/ztombol/bats-assert.git $(TEST_HELPERS)/bats-assert
	pip install formica-cli -U
	pip install awsie -U

command-docs:
	@find scripts/commands -name "*.bash" | awk '{sub(/\.bash/, "", $$0); n=split($$0,file,"/"); sub(/index/, "", file[n]); print "* [`" file[n-1] " " file[n] "`](" $$0 ".md)" }' | sort

LOG_TIMESTAMP=$(shell echo $$(($$(date +%s) * 1000)))
LOG_STREAM_NAME=test-log-stream-$(LOG_TIMESTAMP)

put-log-message:
	aws logs create-log-stream --log-group-name test-log-group --log-stream-name $(LOG_STREAM_NAME)
	aws logs put-log-events --log-group-name test-log-group --log-stream-name  $(LOG_STREAM_NAME) --log-events timestamp=$(LOG_TIMESTAMP),message=TestMessage-$(LOG_TIMESTAMP)
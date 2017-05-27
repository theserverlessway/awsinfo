CONTAINER=flomotlik/awsinfo

docker-build:
	docker build . -t $(CONTAINER)

docker-run:
	bash -c "draws -it $(CONTAINER) bash"

test:

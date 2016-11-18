all: build/index.html

clean:
	docker rmi neeco-api-documents

build:
	@[ -d $@ ] || mkdir -p $@

build/index.html: build/aglio_image $(shell find src)
	docker run --rm\
	    -v $$PWD/build:/aglio/build\
	    -v $$PWD/package.json:/aglio/package.json\
	    -v $$PWD/src:/aglio/src\
	    aglio\
	    npm run postinstall

build/aglio_image: build .make/Dockerfile
	cd .make && docker build -t aglio .
	echo "" > $@

# GDAL python bindings make file.

SHELL = /bin/bash

docker: Dockerfile.wheels build-linux-wheels.sh
	docker build -f Dockerfile.wheels -t storystream/gdal-wheelbuilder .

wheels: docker
	docker run -e PACKAGE_VERSION=${PACKAGE_VERSION} -v `pwd`:/io storystream/gdal-wheelbuilder

# GDAL python bindings make file.

SHELL = /bin/bash

build: Dockerfile.wheels build-linux-wheels.sh
	docker build -f Dockerfile.wheels -t gdal-wheelbuilder:gdal-3.5.1-x86_64 .

arm: Dockerfile.arm build-linux-wheels.sh
	docker build -f Dockerfile.arm -t gdal-wheelbuilder:gdal-3.5.1-arm64 .

wheel: build-linux-wheels.sh
	docker run -v `pwd`:/io gdal-wheelbuilder

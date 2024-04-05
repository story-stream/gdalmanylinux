# GDAL python bindings make file.

SHELL = /bin/bash

all: build arm wheel

build: Dockerfile.wheels build-linux-wheels.sh
	docker build -f Dockerfile.wheels -t storystream/gdal-wheelbuilder:gdal-3.5.1-x86_64 .

arm: Dockerfile.arm build-linux-wheels.sh
	docker build -f Dockerfile.arm -t storystream/gdal-wheelbuilder:gdal-3.5.1-arm64 .

wheel:
	docker run -v `pwd`:/io storystream/gdal-wheelbuilder:gdal-3.5.1-x86_64
	docker run -v `pwd`:/io storystream/gdal-wheelbuilder:gdal-3.5.1-arm64

upload:
	aws s3 cp wheels s3://storystream-gdal/wheels/gdal --recursive

download:
	aws s3 cp s3://storystream-gdal/wheels dist --recursive

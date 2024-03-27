#!/bin/bash
set -e

GDAL_BUILD_PATH=/src/gdal-3.5.1/swig/python
ORIGINAL_PATH=$PATH
UNREPAIRED_WHEELS=/tmp/wheels

# Compile wheels
pushd ${GDAL_BUILD_PATH}
for PYBIN in /opt/python/*/bin; do
    if [[ $PYBIN != *"cp311"* && $PYBIN != *"cp39"* ]]; then
        # Only produce wheels for python versions we support
        continue
    fi

    export PATH=${PYBIN}:$ORIGINAL_PATH
    rm -rf build
    CFLAGS="-std=c++11" python setup.py bdist_wheel -d ${UNREPAIRED_WHEELS} || true
done
popd

# Bundle GEOS into the wheels
for whl in ${UNREPAIRED_WHEELS}/*.whl; do
    auditwheel repair ${whl} -w wheels || true
done

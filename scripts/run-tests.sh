#!/usr/bin/env bash

if ! command -v docker > /dev/null 2>&1; then
  echo "You must have Docker installed"
  exit 1
fi

export TEST_DIR=tests/

if [ $# -eq 0 ]; then
  ADDITIONAL_PARAMS="${TEST_DIR}" # run with default params
else
  ADDITIONAL_PARAMS="$@"  # run with specified params
  TEST_DIR="${@: -1}"  # last param should be the test dir
fi

echo "*****"
echo "Running tests from:         ${TEST_DIR}"
echo "ADDITIONAL_PARAMS:          ${ADDITIONAL_PARAMS}"
echo "*****"

docker build -t zebra-tests $(pwd)
docker run --rm -v $(pwd):/usr/src/zebra-tests zebra-tests "$ADDITIONAL_PARAMS"

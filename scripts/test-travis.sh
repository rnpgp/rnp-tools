#!/bin/sh -e

HOME="/home/travis"

# copy&paste from .travis.yml
export BOTAN_INSTALL="$HOME/builds/botan-install"
export CMOCKA_INSTALL="$HOME/builds/cmocka-install"
export JSON_C_INSTALL="$HOME/builds/json-c-install"
export LOGNAME="Travis"
export BUILD_MODE="normal"

docker start travis-rnp || docker run \
  --name travis-rnp -v $(dirname `realpath -s $0`):/rnp \
  -u travis \
  -w /rnp  \
  -e BOTAN_INSTALL=$BOTAN_INSTALL \
  -e CMOCKA_INSTALL=$CMOCKA_INSTALL \
  -e JSON_C_INSTALL=$JSON_C_INSTALL \
  -e LOGNAME=$LOGNAME \
  -e BUILD_MODE=$BUILD_MODE \
  -dit travisci/ci-garnet:packer-1478744932 tail -f /dev/null

docker exec travis-rnp ./ci/install.sh
docker exec travis-rnp ./ci/main.sh

docker stop travis-rnp

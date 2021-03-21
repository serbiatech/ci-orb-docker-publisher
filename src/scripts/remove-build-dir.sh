#!/usr/bin/env bash

RemoveBuildDir() {

    rm -rf "${BUILD_DIR}"
}

ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    RemoveBuildDir
fi

#!/usr/bin/env bash

FindDockerfiles() {

    local dockerfilesPaths

    dockerfilesPaths=$(find "${SRC_DIR}" -iname "Dockerfile" -type f)

    for filePath in ${dockerfilesPaths}
    do
        echo "${filePath}" >> "${BUILD_DIR}unorderedInheritanceList.txt"
    done
}

ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    FindDockerfiles
fi

#!/usr/bin/env bash

GenerateBuildContext() {

    local context
    local contextPathLength

    local dockerfilePath
    local dockerfileNameCharsCount

    local filePathCharsCount

    while read -r dockerfilePath; do

      filePathCharsCount=$(echo -n "${dockerfilePath}" | wc -c)
      dockerfileNameCharsCount=$(echo -n "${DOCKERFILE_NAME}" | wc -c)

      ((dockerfileNameCharsCount=dockerfileNameCharsCount+1))

      contextPathLength=$((filePathCharsCount-dockerfileNameCharsCount))

      context=$(echo "${dockerfilePath}" | cut -c"1-${contextPathLength}")

      echo "${dockerfilePath} | ${context}" >> "${BUILD_DIR}tmp_${UNORDERED_LIST_NAME}"

    done <"${BUILD_DIR}${UNORDERED_LIST_NAME}"

    mv "${BUILD_DIR}tmp_${UNORDERED_LIST_NAME}" "${BUILD_DIR}${UNORDERED_LIST_NAME}"

    rm -f "${BUILD_DIR}tmp_${UNORDERED_LIST_NAME}"

}

ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    GenerateBuildContext
fi

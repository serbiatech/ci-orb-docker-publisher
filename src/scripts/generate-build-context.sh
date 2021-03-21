#!/usr/bin/env bash

GenerateBuildContext() {

    local context
    local contextPathLength

    local dockerfilePaths
    local dockerfileNameCharsCount

    local filePathCharsCount

    IFS=$'\n' read  -r -d '' -a dockerfilePaths < "${BUILD_FOLDER}unorderedInheritanceList.txt"

    for dockerfilePath in "${dockerfilePaths[@]}"
    do

      filePathCharsCount=$(echo -n "${dockerfilePath}" | wc -c)
      dockerfileNameCharsCount=$(echo -n "Dockerfile" | wc -c)

      ((dockerfileNameCharsCount=dockerfileNameCharsCount+1))

      contextPathLength=$((filePathCharsCount-dockerfileNameCharsCount))

      context=$(echo "${dockerfilePath}" | cut -c"1-${contextPathLength}")

      echo "${dockerfilePath} | ${context}" >> "${BUILD_FOLDER}tmp_unorderedInheritanceList.txt"
    done

    mv "${BUILD_FOLDER}tmp_unorderedInheritanceList.txt" "${BUILD_FOLDER}unorderedInheritanceList.txt"

    rm -f "${BUILD_FOLDER}tmp_unorderedInheritanceList.txt"

}

ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    GenerateBuildContext
fi

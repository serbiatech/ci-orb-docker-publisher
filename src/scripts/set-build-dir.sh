SetBuildDir() {

  rm -rf "${BUILD_DIR}orderedInheritanceList.txt"
  rm -rf "${BUILD_DIR}unorderedInheritanceList.txt"

  mkdir -p "${BUILD_DIR}"
}

ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    SetBuildDir
fi

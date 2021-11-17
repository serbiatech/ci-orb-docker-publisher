setup() {

    source ./src/scripts/remove-build-dir.sh
}

@test 'remove-build-dir-command Test 1: Remove old directory with files.' {

    export BUILD_DIR="./docker-publisher-build/"

    mkdir -p "${BUILD_DIR}"

    echo "namespace/test-image" >> "${BUILD_DIR}orderedInheritanceList.txt"
    echo "namespace/test-image" >> "${BUILD_DIR}unorderedInheritanceList.txt"

    [ -d "${BUILD_DIR}" ]
    [ -f "${BUILD_DIR}orderedInheritanceList.txt" ]
    [ -f "${BUILD_DIR}unorderedInheritanceList.txt" ]

    RemoveBuildDir

    [ ! -f "${BUILD_DIR}orderedInheritanceList.txt" ]
    [ ! -f "${BUILD_DIR}unorderedInheritanceList.txt" ]
    [ ! -d "${BUILD_DIR}" ]

    rm -rf "${BUILD_DIR}"
}

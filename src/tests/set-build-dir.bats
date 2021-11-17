setup() {

    source ./src/scripts/set-build-dir.sh
}

@test 'set-build-dir-command Test 1: Create empty directory.' {

    export BUILD_DIR="./docker-publisher-build/"

    [ ! -d "${BUILD_DIR}" ]
    [ ! -f "${BUILD_DIR}orderedInheritanceList.txt" ]
    [ ! -f "${BUILD_DIR}unorderedInheritanceList.txt" ]

    SetBuildDir

    [ -d "${BUILD_DIR}" ]
    [ ! -f "${BUILD_DIR}orderedInheritanceList.txt" ]
    [ ! -f "${BUILD_DIR}unorderedInheritanceList.txt" ]

    rm -rf "${BUILD_DIR}"
}

@test 'set-build-dir-command Test 2: Remove old directory with files and create empty directory.' {

    export BUILD_DIR="./docker-publisher-build/"

    mkdir -p "${BUILD_DIR}"

    echo "namespace/test-image" >> "${BUILD_DIR}orderedInheritanceList.txt"
    echo "namespace/test-image" >> "${BUILD_DIR}unorderedInheritanceList.txt"

    [ -d "${BUILD_DIR}" ]
    [ -f "${BUILD_DIR}orderedInheritanceList.txt" ]
    [ -f "${BUILD_DIR}unorderedInheritanceList.txt" ]

    SetBuildDir

    [ -d "${BUILD_DIR}" ]
    [ ! -f "${BUILD_DIR}orderedInheritanceList.txt" ]
    [ ! -f "${BUILD_DIR}unorderedInheritanceList.txt" ]

    rm -rf "${BUILD_DIR}"
}

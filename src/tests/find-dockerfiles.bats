setup() {

    source ./src/scripts/find-dockerfiles.sh
}

@test 'find-dockerfiles-command: Create list with paths to the Dockerfiles.' {

    local firstDockerfileFound
    local secondDockerfileFound

    export BUILD_DIR="./docker-publisher-build/"
    export SRC_DIR="./docker-publisher-build/src/"

    mkdir -p "${BUILD_DIR}"
    mkdir -p "${SRC_DIR}test/1/"
    mkdir -p "${SRC_DIR}test/2/"

    echo "FROM namespace/test-image" >> "${SRC_DIR}test/1/Dockerfile"
    echo "FROM namespace/test-image" >> "${SRC_DIR}test/2/Dockerfile"

    [ -d "${BUILD_DIR}" ]
    [ -f "${SRC_DIR}test/1/Dockerfile" ]
    [ -f "${SRC_DIR}test/2/Dockerfile" ]

    FindDockerfiles

    [ -f "${BUILD_DIR}unorderedInheritanceList.txt" ]

    firstDockerfileFound=$(grep -Fxq "./docker-publisher-build/src/test/1/Dockerfile" "${BUILD_DIR}unorderedInheritanceList.txt")
    secondDockerfileFound=$(grep -Fxq "./docker-publisher-build/src/test/2/Dockerfile" "${BUILD_DIR}unorderedInheritanceList.txt")

    [ "${firstDockerfileFound}" -eq 0 ]
    [ "${secondDockerfileFound}" -eq 0 ]

    rm -rf "${BUILD_DIR}"
}

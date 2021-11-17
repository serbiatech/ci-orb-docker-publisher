setup() {

    source ./src/scripts/generate-build-context.sh
}

@test 'generate-build-context-command Test 1: Generate build context for Dockerfiles.' {

    export BUILD_DIR="./docker-publisher-build/"
    export DOCKERFILE_NAME="Dockerfile"
    export UNORDERED_LIST_NAME="unorderedInheritanceList.txt"

    local firstDockerfileFound
    local secondDockerfileFound

    mkdir -p "${BUILD_DIR}"

    [ -d "${BUILD_DIR}" ]

    echo "./src/testNamespace/composer/2-php8.0-cli/${DOCKERFILE_NAME}" >> "${BUILD_DIR}${UNORDERED_LIST_NAME}"
    echo "./src/testNamespace/php/8.0-cli/${DOCKERFILE_NAME}" >> "${BUILD_DIR}${UNORDERED_LIST_NAME}"

    [ -f "${BUILD_DIR}${UNORDERED_LIST_NAME}" ]

    GenerateBuildContext

    firstDockerfileFound=$(grep "\./src/testNamespace/composer/2-php8.0-cli/${DOCKERFILE_NAME} | \./src/testNamespace/composer/2-php8.0-cli" "${BUILD_DIR}${UNORDERED_LIST_NAME}")
    secondDockerfileFound=$(grep "\./src/testNamespace/php/8.0-cli/${DOCKERFILE_NAME} | \./src/testNamespace/php/8.0-cli" "${BUILD_DIR}${UNORDERED_LIST_NAME}")

    [ -n "${firstDockerfileFound}" ]
    [ -n "${secondDockerfileFound}" ]

    rm -rf "${BUILD_DIR}"
}

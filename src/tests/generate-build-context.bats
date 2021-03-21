setup() {

    source ./src/scripts/generate-build-context.sh
}

@test 'generate-build-context-command: Generate build context for Dockerfiles.' {

    export BUILD_DIR="./docker-publisher-build/"

    local firstDockerfileFound
    local secondDockerfileFound

    mkdir -p "${BUILD_DIR}"

    [ -d "${BUILD_DIR}" ]

    echo "./src/testNamespace/composer/2-php8.0-cli/Dockerfile" >> "${BUILD_DIR}unorderedInheritanceList.txt"
    echo "./src/testNamespace/php8.0-cli/Dockerfile" >> "${BUILD_DIR}unorderedInheritanceList.txt"

    [ -f "${BUILD_DIR}unorderedInheritanceList.txt" ]

    GenerateBuildContext

    firstDockerfileFound=$(grep "\./docker-publisher-build/src/testNamespace/composer/2-php8.0-cli/Dockerfile | \./docker-publisher-build/src/testNamespace/composer/2-php8.0-cli" "${BUILD_DIR}unorderedInheritanceList.txt")
    secondDockerfileFound=$(grep "\./docker-publisher-build/src/testNamespace/php/8.0-cli/Dockerfile | \./docker-publisher-build/src/testNamespace/php/8.0-cli" "${BUILD_DIR}unorderedInheritanceList.txt")

    [ -n "${firstDockerfileFound}" ]
    [ -n "${secondDockerfileFound}" ]

    rm -rf "${BUILD_DIR}"
}

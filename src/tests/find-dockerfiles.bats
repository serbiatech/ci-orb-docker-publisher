setup() {

    source ./src/scripts/find-dockerfiles.sh
}

@test 'find-dockerfiles-command: Create list with paths to the Dockerfiles.' {

    local firstDockerfileFound
    local secondDockerfileFound

    export BUILD_DIR="./docker-publisher-build/"
    export SRC_DIR="${BUILD_DIR}src/"

    mkdir -p "${SRC_DIR}testNamespace/composer/2-php8.0-cli"
    mkdir -p "${SRC_DIR}testNamespace/php/8.0-cli"

    cat <<EOF >> "${SRC_DIR}testNamespace/php/8.0-cli/Dockerfile"
    FROM php:8.0-cli-alpine

    RUN apk update
    RUN apk --no-cache upgrade
EOF

    cat <<EOF >> "${SRC_DIR}testNamespace/composer/2-php8.0-cli/Dockerfile"
    FROM composer:2 AS composer

    FROM testNamespace/php8.0-cli:latest

    COPY --from=composer /usr/bin/composer /usr/bin/composer

    RUN apk update
    RUN apk --no-cache upgrade
EOF

    [ -d "${BUILD_DIR}" ]
    [ -f "${SRC_DIR}testNamespace/composer/2-php8.0-cli/Dockerfile" ]
    [ -f "${SRC_DIR}testNamespace/php/8.0-cli/Dockerfile" ]

    cat "${SRC_DIR}testNamespace/composer/2-php8.0-cli/Dockerfile"
    cat "${SRC_DIR}testNamespace/php/8.0-cli/Dockerfile"

#    export BUILD_DIR="./docker-publisher-build/"
#    export SRC_DIR="./docker-publisher-build/src/"
#
#    mkdir -p "${BUILD_DIR}"
#    mkdir -p "${SRC_DIR}test/1-test/"
#    mkdir -p "${SRC_DIR}test/2-test/"
#
#    echo "FROM namespace/test-image" >> "${SRC_DIR}test/1-test/Dockerfile"
#    echo "FROM namespace/test-image" >> "${SRC_DIR}test/2-test/Dockerfile"
#
#    [ -d "${BUILD_DIR}" ]
#    [ -f "${SRC_DIR}test/1-test/Dockerfile" ]
#    [ -f "${SRC_DIR}test/2-test/Dockerfile" ]
#
#    FindDockerfiles
#
#    [ -f "${BUILD_DIR}unorderedInheritanceList.txt" ]
#
#    firstDockerfileFound=$(grep "1-test" "${BUILD_DIR}unorderedInheritanceList.txt")
#    secondDockerfileFound=$(grep "2-test" "${BUILD_DIR}unorderedInheritanceList.txt")
#
#    [ -n "${firstDockerfileFound}" ]
#    [ -n "${secondDockerfileFound}" ]
#
#    rm -rf "${BUILD_DIR}"
}

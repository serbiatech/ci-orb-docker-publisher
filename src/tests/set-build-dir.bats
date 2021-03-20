setup() {

    source ./src/scripts/set-build-dir.sh
}

@test 'set-build-dir-command: Create empty build directory' {

    export BUILD_DIR="./build/"

    ! [ -d "${BUILD_DIR}" ]

    SetBuildDir

    [ -d "${BUILD_DIR}" ]
}

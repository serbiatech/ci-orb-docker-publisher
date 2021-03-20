#!/usr/bin/env bash

# Constants

DOCKER_SOCKET=/var/run/docker.sock
CIRCLECI_CONFIG=.circleci/config.yml
CIRCLECI_TEMPORARY_CONFIG=tmp_config.yml
CIRCLECI_LOCAL_BUILD_CONFIG=local_build_config.yml
CIRCLECI_LOCAL_BUILD_REPOSITORY=/tmp/_circleci_local_build_repo

# Read job name and options replace from input

JOB_NAME=$1
OPTIONS_REPLACE=$2

# Remove old config files if they exists

rm -f "${CIRCLECI_LOCAL_BUILD_CONFIG}"
rm -f "${CIRCLECI_TEMPORARY_CONFIG}"

# Process local build config

if [ -n "${OPTIONS_REPLACE}" ]
then
  cp "${CIRCLECI_CONFIG}" "${CIRCLECI_TEMPORARY_CONFIG}"

  IFS='|' read -r -a options <<< "${OPTIONS_REPLACE}"
  unset IFS

  for option in "${options[@]}"
  do
    set -e
    search=$(echo "${option}" | cut -d'>' -f1)
    replace=$(echo "${option}" | cut -d'>' -f2)

    searchPattern="$(echo "${search}" | cut -d'=' -f1): $(echo "${search}" | cut -d'=' -f2)"
    replacePattern="$(echo "${replace}" | cut -d'=' -f1): $(echo "${replace}" | cut -d'=' -f2)"

    sed -i -e "s|${searchPattern}|${replacePattern}|" "${CIRCLECI_TEMPORARY_CONFIG}"

    circleci config process "${CIRCLECI_TEMPORARY_CONFIG}" >> "${CIRCLECI_LOCAL_BUILD_CONFIG}"
    rm -f "${CIRCLECI_TEMPORARY_CONFIG}"
  done
else
  circleci config process "${CIRCLECI_CONFIG}" >> "${CIRCLECI_LOCAL_BUILD_CONFIG}"
fi

# Run command for the local execution of the job

docker run -v "${DOCKER_SOCKET}":"${DOCKER_SOCKET}" \
       -v "${HOST_PROJECT_ROOT}":"${CIRCLECI_LOCAL_BUILD_REPOSITORY}" \
       -w "${HOST_PROJECT_ROOT}" \
       circleci/picard circleci execute \
       -c "${CIRCLECI_LOCAL_BUILD_REPOSITORY}"/"${CIRCLECI_LOCAL_BUILD_CONFIG}" \
       --job "${JOB_NAME}"

# Remove local build config

rm -f "${CIRCLECI_LOCAL_BUILD_CONFIG}"

# Jobs constants

BATS_JOB=bats/run
LINT_JOB=orb-tools/lint
PACK_JOB=orb-tools/pack
SHELLCHECK_JOB=shellcheck/check

# Config options replace config

LINT_OPTIONS_REPLACE="custom-rules-filepath=.yamllint>custom-rules-filepath=/tmp/_circleci_local_build_repo/.yamllint"

# Commands

lint:
	/bin/bash /home/sphere-master/circleci-local-execute.sh ${LINT_JOB} ${LINT_OPTIONS_REPLACE}

pack:
	/bin/bash /home/sphere-master/circleci-local-execute.sh ${PACK_JOB}

shellcheck:
	/bin/bash /home/sphere-master/circleci-local-execute.sh ${SHELLCHECK_JOB}

bats:
	/bin/bash /home/sphere-master/circleci-local-execute.sh ${BATS_JOB}

local-execute:
	/bin/bash /home/sphere-master/circleci-local-execute.sh $(job) $(optionsReplace)

help:
	# Usage:
	#   make <target> [OPTION=value]
	#
	# Targets:
	#	lint			Run lint tests on src folder
	#	pack			Run orb packing and validation
	#	shellcheck		Run shellcheck tests on src/scripts folder
	#	bats			Run bats tests on src/scripts folder
	#   local-execute   Run job locally where option job=<job name from .circleci/config.yml> is required
	#
	#   help            You're looking at it!

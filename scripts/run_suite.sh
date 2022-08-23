#!/usr/bin/env bash

# Script executed by docker container to run robot tests
set -e
EXEC_SYN_CHECK="robot --dryrun "
EXEC="robot "

onSyntaxCheckFail() {
	echo "==================="
	echo "SYNTAX CHECK FAILED"
	echo ""
	exit
}

onSyntaxCheckPass() {
	echo "==================="
	echo "SYNTAX CHECK PASSED"
	echo ""
}

# Robot syntax check
dryRunTest() {
	echo ${EXEC_SYN_CHECK}${CMD}
	``${EXEC_SYN_CHECK}${CMD}`` || onSyntaxCheckFail
	onSyntaxCheckPass
}

runTest() {
	echo ${EXEC}${CMD}
	``${EXEC}${CMD}``
}



#
# 	SCRIPT BODY
#

# Uncomment one of the following to create command to run tests
#
# run all suites in /suites folder
# CMD="--variable TEST_ENV:docker --console verbose --outputdir /reports /suites"
#
# run all tests in /suites folder with a tag
# CMD="--variable TEST_ENV:docker --console -i tag_name verbose --outputdir /reports /suites"
#
# run all tests in /suites folder with a tag and debug loglevel
# CMD="--variable TEST_ENV:docker --loglevel debug --console -i tag_name verbose --outputdir /reports /suites"
#
# run only one suite from /suites folder
# or leave it empty to run all suites
SUITE_NAME="web_tests"
CMD="--variable TEST_ENV:local --console verbose  --outputdir /reports /suites/${SUITE_NAME}"


# do a syntax check
dryRunTest

# run the real test
runTest



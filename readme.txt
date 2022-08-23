This folder contains robot tests. Folder web_tests is the main test suite. If you want to run this test
suite, simply execute run-tests.sh script.

Note that there's also WebUtils.py library which contains some useful stuff (should the need rise,
feel free to expand it). In order for it to work, you should copy it to folder in your PATH (/usr/local/bin or something)
as robot checks for libraries in PATH folders.

suites folder
 - contains robot test suites

pythonpath folder
 - contains python scripts to be copied to folder in $PATH variable

scripts
 - contains scripts for running robot tests in docker

reports
 - output folder for tests



 What to do when you haven't seen this folder for 2+ months and want to run UI tests
 ====================================================================================

 1. Build docker image which contains robot environment
 	docker build -t robot-image .

 2. Set docker image name in run_tests_docker.sh

 2. (Optional) Choose a name of suite from suites/ folder to run (e.g. hello_world)

 3. (Optional) Use this name in scripts/run_suite.sh script

 4. Execute ./run_tests_docker.sh

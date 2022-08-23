*** Settings ***
Documentation   Empty test used for verifying your docker/robot setup.
Library         libs/TestRobotLibrary.py
Force Tags      hello-world

*** Test Cases ***
Hello World
    [Documentation]     Prints a message then exits.
    ${quote}=           Random Quote
    Log To Console      ${quote}



*** Settings ***
Library    SeleniumLibrary
Resource   locators.robot

*** Keywords ***
Perform Login To GitHub
    [Arguments]    ${username}    ${password}
    Input Text    ${LOGIN_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}
    Click Button  ${SUBMIT_BUTTON}

*** Keywords ***
Run Login Test
    [Arguments]    ${username}    ${password}
    Go To GitHub Home Page
    Click Sign In
    Perform Login To GitHub    ${username}    ${password}
    [Teardown]    Close Browser


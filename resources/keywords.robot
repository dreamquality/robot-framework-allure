*** Settings ***
Library    SeleniumLibrary
Resource   locators.robot

*** Keywords ***
Perform Login To GitHub
    [Arguments]    ${username}    ${password}
    Input Text    ${LOGIN_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}
    Click Button  ${SUBMIT_BUTTON}

*** Settings ***
Library    SeleniumLibrary
Resource   BasePage.robot
Resource   ../resources/locators.robot

*** Keywords ***
Go To GitHub Home Page
    Open Or Switch Browser    ${GITHUB_URL}

Search Repository
    [Arguments]    ${repo_name}
    Wait For Element And Input Text    ${SEARCH_INPUT}    ${repo_name}
    Press Keys    ${SEARCH_INPUT}    ENTER

Click Sign In
    Wait For Element And Click    ${SIGN_IN_BUTTON}

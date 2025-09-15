*** Settings ***
Resource    ../../variables/global_variables.robot
Resource    ../../pages/GitHubPage.robot
Resource    ../../resources/keywords.robot
Library     SeleniumLibrary
Library     Collections
Library     JSONLibrary

*** Variables ***
${SIGN_IN_PAGE_URL}    https://github.com/login
${EXPECTED_TITLE}      The world’s leading software development platform · GitHub

*** Test Cases ***
Test GitHub Home Page Load
    Open Or Switch Browser    ${GITHUB_URL}
    Title Should Be           ${EXPECTED_TITLE}
    [Teardown]    Close Browser

Test GitHub Search Repository
    Open Or Switch Browser    ${GITHUB_URL}
    Search Repository         ${REPO_NAME}
    Element Should Be Visible    xpath=//a[contains(@href, '${REPO_NAME}')]
    [Teardown]    Close Browser

Test GitHub Sign In Page Load
    Open Or Switch Browser    ${GITHUB_URL}
    Click Sign In
    Element Should Be Visible    ${LOGIN_FIELD}
    Location Should Be        ${SIGN_IN_PAGE_URL}
    Element Text Should Be    ${SUBMIT_BUTTON}    Sign in
    [Teardown]    Close Browser

Test Valid Logins From JSON
    Run Login Test With JSON Data

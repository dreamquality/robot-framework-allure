*** Settings ***
Library    SeleniumLibrary
Library    JSONLibrary
Resource   locators.robot
Resource   ../pages/GitHubPage.robot

*** Keywords ***
Perform Login To GitHub
    [Arguments]    ${username}    ${password}
    Input Text    ${LOGIN_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}
    Click Button  ${SUBMIT_BUTTON}

Run Login Test
    [Arguments]    ${username}    ${password}
    Go To GitHub Home Page
    Click Sign In
    Perform Login To GitHub    ${username}    ${password}
    [Teardown]    Close Browser

Run Login Test With JSON Data
    ${LOGIN_DATA}=    Load JSON From File    ../../variables/login_data.json
    ${username1}=    Get Value From Json    ${LOGIN_DATA}    $.valid_logins[0].username
    ${password1}=    Get Value From Json    ${LOGIN_DATA}    $.valid_logins[0].password
    ${username2}=    Get Value From Json    ${LOGIN_DATA}    $.valid_logins[1].username
    ${password2}=    Get Value From Json    ${LOGIN_DATA}    $.valid_logins[1].password
    
    Run Login Test    ${username1[0]}    ${password1[0]}
    Run Login Test    ${username2[0]}    ${password2[0]}


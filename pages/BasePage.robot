*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER_RUNNING}    False

*** Keywords ***
Open Or Switch Browser
    [Arguments]    ${url}
    Run Keyword If    ${BROWSER_RUNNING} == ${False}
    ...    Open Browser    ${url}    chrome
    ...    Set Global Variable    ${BROWSER_RUNNING}    True
    ...    ELSE
    Go To    ${url}

Wait For Element And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}

*** Settings ***
Library    SeleniumLibrary
Resource   ../variables/config.robot

*** Variables ***
${BROWSER_RUNNING}    False

*** Keywords ***
Open Or Switch Browser
    [Arguments]    ${url}
    Run Keyword If    ${BROWSER_RUNNING} == ${False}
    ...    Open Browser And Set Flag    ${url}
    ...    ELSE
    ...    Go To    ${url}

Open Browser And Set Flag
    [Arguments]    ${url}
    Open Browser    ${url}    chrome    options=${BROWSER_OPTIONS}
    Set Global Variable    ${BROWSER_RUNNING}    True

Wait For Element And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}

Wait For Element And Input Text
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    10s
    Input Text    ${locator}    ${text}

*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER_RUNNING}    False

*** Keywords ***
Open Browser With Options
    [Arguments]    ${url}
    Open Browser    ${url}    chrome    options=add_chrome_options

Add Chrome Options
    [Return]    --headless

Wait For Element And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}

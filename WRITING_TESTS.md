# Writing Tests Guide for Robot Framework TAF

This guide provides instructions on how to write tests for this Robot Framework Test Automation Framework (TAF).

## Table of Contents
- [Project Architecture](#project-architecture)
- [Writing Your First Test](#writing-your-first-test)
- [Best Practices](#best-practices)
- [Common Patterns](#common-patterns)
- [Advanced Topics](#advanced-topics)
- [Troubleshooting](#troubleshooting)

## Project Architecture

This project follows the **Page Object Model (POM)** design pattern:

```
robot_project/
├── tests/              # Test cases (what to test)
├── pages/              # Page objects (how to interact with pages)
├── resources/          # Shared keywords and locators
├── variables/          # Configuration and test data
```

### Key Components

1. **Tests** (`tests/`): High-level test scenarios
2. **Pages** (`pages/`): Page-specific actions and elements
3. **Keywords** (`resources/keywords.robot`): Reusable test logic
4. **Locators** (`resources/locators.robot`): Element selectors
5. **Variables** (`variables/`): Configuration and test data

## Writing Your First Test

### Step 1: Create a Test File

Create a new `.robot` file in the `tests/` directory:

```robot
*** Settings ***
Resource    ../../variables/global_variables.robot
Resource    ../../pages/YourPage.robot
Resource    ../../resources/keywords.robot
Library     SeleniumLibrary

*** Variables ***
${YOUR_URL}    https://example.com

*** Test Cases ***
Test Example Scenario
    Open Or Switch Browser    ${YOUR_URL}
    # Add your test steps here
    [Teardown]    Close Browser
```

### Step 2: Define Locators

Add your page element locators in `resources/locators.robot`:

```robot
*** Variables ***
${SUBMIT_BUTTON}    xpath=//button[@type='submit']
${EMAIL_FIELD}      css=#email
${ERROR_MESSAGE}    xpath=//div[@class='error']
```

### Step 3: Create Page Keywords

Create page-specific keywords in `pages/YourPage.robot`:

```robot
*** Settings ***
Library    SeleniumLibrary
Resource   BasePage.robot
Resource   ../resources/locators.robot

*** Keywords ***
Fill Login Form
    [Arguments]    ${email}    ${password}
    Wait For Element And Input Text    ${EMAIL_FIELD}    ${email}
    Wait For Element And Input Text    ${PASSWORD_FIELD}    ${password}

Submit Form
    Wait For Element And Click    ${SUBMIT_BUTTON}
```

### Step 4: Write Test Logic

Use the keywords in your test:

```robot
*** Test Cases ***
Test Successful Login
    Open Or Switch Browser    ${LOGIN_URL}
    Fill Login Form    user@example.com    password123
    Submit Form
    Element Should Be Visible    ${WELCOME_MESSAGE}
    [Teardown]    Close Browser
```

## Best Practices

### 1. Follow the Page Object Model

**DO:**
```robot
# In pages/LoginPage.robot
*** Keywords ***
Login With Credentials
    [Arguments]    ${username}    ${password}
    Wait For Element And Input Text    ${USERNAME_FIELD}    ${username}
    Wait For Element And Input Text    ${PASSWORD_FIELD}    ${password}
    Wait For Element And Click    ${SUBMIT_BUTTON}

# In tests/test_login.robot
*** Test Cases ***
Test Valid Login
    Open Or Switch Browser    ${LOGIN_URL}
    Login With Credentials    valid_user    valid_pass
    [Teardown]    Close Browser
```

**DON'T:**
```robot
# Putting all logic directly in test
*** Test Cases ***
Test Valid Login
    Open Or Switch Browser    ${LOGIN_URL}
    Input Text    xpath=//input[@name='username']    valid_user
    Input Text    xpath=//input[@name='password']    valid_pass
    Click Button    xpath=//button[@type='submit']
    [Teardown]    Close Browser
```

### 2. Use Descriptive Names

- Test case names should describe what is being tested
- Keyword names should describe actions
- Variables should be UPPERCASE with underscores

**Good:**
```robot
Test User Can Submit Valid Registration Form
Search For Product By Name
${MAX_WAIT_TIME}    30s
```

**Bad:**
```robot
test1
do_stuff
${x}    30s
```

### 3. Organize Imports Properly

Always organize imports in this order:
```robot
*** Settings ***
Library     SeleniumLibrary
Library     Collections
Resource    ../../variables/global_variables.robot
Resource    ../../pages/YourPage.robot
Resource    ../../resources/keywords.robot
```

### 4. Use Teardowns for Cleanup

Always close browsers and clean up resources:
```robot
*** Test Cases ***
Test Example
    Open Or Switch Browser    ${URL}
    # test steps here
    [Teardown]    Close Browser
```

### 5. Avoid Duplicate Keywords Section

**DO:**
```robot
*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
First Keyword
    Log    First

Second Keyword
    Log    Second
```

**DON'T:**
```robot
*** Keywords ***
First Keyword
    Log    First

*** Keywords ***
Second Keyword
    Log    Second
```

## Common Patterns

### Pattern 1: Data-Driven Testing with JSON

Store test data in JSON files:

```json
// variables/test_data.json
{
    "users": [
        {"email": "user1@test.com", "password": "pass1"},
        {"email": "user2@test.com", "password": "pass2"}
    ]
}
```

Load and use in tests:
```robot
*** Settings ***
Library    JSONLibrary

*** Keywords ***
Test All Users From JSON
    ${TEST_DATA}=    Load JSON From File    ../variables/test_data.json
    ${user1_email}=    Get Value From Json    ${TEST_DATA}    $.users[0].email
    ${user1_pass}=    Get Value From Json    ${TEST_DATA}    $.users[0].password
    Login With Credentials    ${user1_email[0]}    ${user1_pass[0]}
```

### Pattern 2: Reusable Wait Keywords

Use the base page wait keywords:
```robot
Wait For Element And Click    ${BUTTON_LOCATOR}
Wait For Element And Input Text    ${INPUT_LOCATOR}    ${TEXT}
```

### Pattern 3: Browser Management

Use the `Open Or Switch Browser` keyword to reuse browser instances:
```robot
*** Test Cases ***
Test Multiple Pages
    Open Or Switch Browser    ${URL_1}
    # interact with page 1
    Open Or Switch Browser    ${URL_2}
    # browser navigates to page 2 without opening new window
    [Teardown]    Close Browser
```

### Pattern 4: Conditional Logic

Use Robot Framework's built-in conditional keywords:
```robot
*** Keywords ***
Verify Login Result
    [Arguments]    ${should_succeed}
    Run Keyword If    ${should_succeed}
    ...    Element Should Be Visible    ${WELCOME_MESSAGE}
    ...    ELSE
    ...    Element Should Be Visible    ${ERROR_MESSAGE}
```

## Advanced Topics

### Using Variables from Config

Define environment-specific settings in `variables/config.robot`:
```robot
*** Variables ***
${TIMEOUT}              10s
${BROWSER_OPTIONS}      add_argument("--headless");add_argument("--no-sandbox")
```

Use in tests:
```robot
Open Browser    ${URL}    chrome    options=${BROWSER_OPTIONS}
Wait Until Element Is Visible    ${LOCATOR}    ${TIMEOUT}
```

### Parallel Execution with Pabot

Tests can run in parallel using Pabot:
```bash
pabot --processes 4 --outputdir reports tests/
```

Write tests to be independent - avoid shared state between tests.

### Allure Reporting Integration

Tests automatically generate Allure reports when run with the listener:
```bash
robot --listener allure_robotframework tests/
```

View reports:
```bash
allure serve output/allure
```

### Custom Keywords in Resources

Create reusable keywords in `resources/keywords.robot`:
```robot
*** Keywords ***
Verify Page Title
    [Arguments]    ${expected_title}
    ${actual_title}=    Get Title
    Should Be Equal    ${actual_title}    ${expected_title}
```

## Troubleshooting

### Common Issues

#### Issue 1: Element Not Found
**Problem:** `Element with locator 'xpath=//button' not found`

**Solutions:**
- Use `Wait Until Element Is Visible` before interacting
- Verify the locator is correct using browser DevTools
- Check if element is in an iframe
- Increase timeout value

#### Issue 2: Duplicate Keywords Section
**Problem:** `Creating keyword 'My Keyword' failed: Keyword with same name defined multiple times.`

**Solution:**
Remove duplicate `*** Keywords ***` headers. Use only one per file.

#### Issue 3: Resource Not Found
**Problem:** `Resource file '../pages/MyPage.robot' does not exist.`

**Solution:**
Check relative paths from your test file location. Use:
- `../../pages/MyPage.robot` for files in tests/subdirectory/
- `../pages/MyPage.robot` for files in tests/

#### Issue 4: Browser Driver Not Found
**Problem:** `Unable to obtain driver for chrome`

**Solutions:**
- Install ChromeDriver: `apt-get install chromium-chromedriver` (Linux)
- Or use WebDriver Manager
- Ensure driver is in system PATH
- For CI, use headless mode in `variables/config.robot`

### Validation Commands

Before running actual tests:

```bash
# Syntax check only (fast, no browser needed)
robot --dryrun tests/

# Run specific test file
robot --outputdir reports tests/github/test_github.robot

# Run with specific tag
robot --include smoke --outputdir reports tests/

# Run in verbose mode for debugging
robot --loglevel DEBUG --outputdir reports tests/
```

## Quick Reference

### Common Keywords

| Keyword | Purpose | Example |
|---------|---------|---------|
| `Open Or Switch Browser` | Open browser or navigate | `Open Or Switch Browser ${URL}` |
| `Wait For Element And Click` | Wait and click element | `Wait For Element And Click ${BUTTON}` |
| `Wait For Element And Input Text` | Wait and input text | `Wait For Element And Input Text ${FIELD} text` |
| `Element Should Be Visible` | Assert element visible | `Element Should Be Visible ${LOCATOR}` |
| `Close Browser` | Close browser | `[Teardown] Close Browser` |

### Locator Strategies

| Strategy | Example | When to Use |
|----------|---------|-------------|
| `xpath` | `xpath=//button[@id='submit']` | Complex selections |
| `css` | `css=#submit` | Class/ID selections |
| `id` | `id=submit` | Elements with ID |
| `name` | `name=username` | Form elements |

### Resource Imports

| Import Type | Example |
|-------------|---------|
| Library | `Library SeleniumLibrary` |
| Resource | `Resource ../pages/MyPage.robot` |
| Variables | `Variables ../variables/config.py` |

## Example: Complete Test File

```robot
*** Settings ***
Resource    ../../variables/global_variables.robot
Resource    ../../pages/GitHubPage.robot
Resource    ../../resources/keywords.robot
Library     SeleniumLibrary
Library     Collections

*** Variables ***
${SEARCH_TERM}    robotframework
${TIMEOUT}        10s

*** Test Cases ***
Test GitHub Search Functionality
    [Documentation]    Verify that searching on GitHub returns results
    [Tags]    smoke    search
    Open Or Switch Browser    ${GITHUB_URL}
    Search Repository    ${SEARCH_TERM}
    Element Should Be Visible    xpath=//a[contains(@href, 'robotframework')]
    [Teardown]    Close Browser

Test GitHub Navigation
    [Documentation]    Verify navigation to sign in page
    [Tags]    smoke    navigation
    Open Or Switch Browser    ${GITHUB_URL}
    Click Sign In
    Location Should Be    https://github.com/login
    [Teardown]    Close Browser
```

## Additional Resources

- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [SeleniumLibrary Documentation](https://robotframework.org/SeleniumLibrary/)
- [Robot Framework Best Practices](https://github.com/robotframework/HowToWriteGoodTestCases/blob/master/HowToWriteGoodTestCases.rst)
- Project README: `README.md`
- Running Tests Guide: `RUNNING_TESTS.md`

---

**Happy Testing! 🤖**

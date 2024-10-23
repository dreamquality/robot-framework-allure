
# Robot Framework Project

This project is an example of a Robot Framework test automation setup, implementing best practices including:
- Page Object Model (POM)
- Parameterization of tests
- Parallel execution with Pabot
- Integration with Allure for reporting

## Project Structure

```
robot_project/
│
├── tests/                      # Test cases directory
│   └── github/
│       └── test_github.robot   # GitHub test cases
│
├── pages/                      # Page Object files
│
├── resources/                  # Shared resources like keywords and locators
│
├── variables/                  # Global variables and configuration
│
├── reports/                    # Allure reports
│
├── logs/                       # Log files
│
├── requirements.txt            # Python dependencies
│
├── robot_settings.py           # Script to run tests
│
└── .github/workflows/          # CI configuration
```

## Setup Instructions

### 1. Install Python Dependencies

Create a virtual environment and install the required packages:

```bash
python -m venv venv
source venv/bin/activate  # On Windows, use: venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Running Tests

To run tests with Robot Framework and Pabot (for parallel execution), use:

```bash
python robot_settings.py
```

This will execute the tests in the `tests/` directory and save the results in the `reports/` directory.

### 3. Generating Allure Reports

To generate an Allure report after test execution, use the following command:

```bash
allure generate reports -o reports/allure-report
```

### 4. Viewing Allure Reports

To serve the Allure report in a browser, use:

```bash
allure serve reports
```

This command will start a local server and automatically open the report in your default browser.

## CI Integration

The project is set up to run tests automatically via GitHub Actions, with results being uploaded as an artifact and a Slack notification sent (if configured).

## Notes

- Ensure that the browser drivers (e.g., ChromeDriver, GeckoDriver) are installed and available in your system's PATH.
- Update the credentials and variables in the `variables/global_variables.robot` and `variables/login_data.json` files as needed.
- Adjust the browser settings and other configurations in `variables/config.robot`.
